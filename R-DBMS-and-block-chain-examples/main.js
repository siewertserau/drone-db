const SHA256 = require('crypto-js/sha256');  // needed for hash chain

class Localization{
    constructor(fromTransmitter, toReceiver, amount, latitude, longitude, altitude){
        this.fromTransmitter = fromTransmitter;  // e.g. icao
        this.toReceiver = toReceiver;            // e.g. another icao or groundstation ID
        this.amount = amount;                    // credit exchange for localization
        this.latitude = latitude;
        this.longitude = longitude;
        this.altitude = altitude;
    }
}

class Block {
    constructor(timestamp, localizations, previousHash = '') {
        //this.index = index; - base on position in chain array
        this.timestamp = timestamp;
        this.localizations = localizations;
        this.previousHash = previousHash;
        this.hash = '';
        this.nonce = 0;
    }

    calculateHash() {
        return SHA256(this.previousHash + this.timestamp + this.nonce).toString();
    }

    mineBlock(difficulty) {
        while(this.hash.substring(0, difficulty) != Array(difficulty + 1).join("0")) {
            this.nonce++;
            this.hash = this.calculateHash();
        }

        console.log("Block mined: " + this.hash);
    }
}

class Blockchain {
        constructor(){
            this.chain = [this.createGenesisBlock()];
            this.difficulty = 4;
            this.pendingLocalizations = [];
            this.miningReward = 1;
        }

        createGenesisBlock(){
            return new Block("01/01/2018", "Genesis block", "0");
        }

        getLatestBlock(){
            return this.chain[this.chain.length -1];
        }

        // simple test  method for chain replaced by mining
        addBlock(newBlock) {
            newBlock.previousHash = this.getLatestBlock().hash;
            newBlock.mineBlock(this.difficulty); // proof of work mining
            this.chain.push(newBlock);
        }

        minePendingLocalizations(miningRewardAddress){
            let block = new Block(Date.now(), this.pendingLocalizations); // unlimited chain
            block.previousHash = this.getLatestBlock().hash;
            block.mineBlock(this.difficulty);

            console.log('Block successfully mined!');
            this.chain.push(block);

            // peer to peer network ensures reward is consistent, localization is nowhere by default
            this.pendingLocalizations = [
                new Localization(null, miningRewardAddress, this.miningReward, 0, 0, 0)
            ];
        }

        createLocalization(localization) {
            this.pendingLocalizations.push(localization);
        }

        getBalanceOfAddress(address) {
            let balance = 0;

            for(const block of this.chain) {
                for(const location of block.localizations) {
                    if(location.fromTransmitter == address) {
                        balance -= trans.amount;
                    }

                    if(location.toReceiver == address) {
                        balance += location.amount;
                    }
                }
            }

            return balance;
        }

        isChainValid() {
            for(let i = 1; i < this.chain.length; i++) {
                const currentBlock = this.chain[i];
                const previousBlock = this.chain[i - 1];

                console.log("Current block: " + currentBlock.hash + " ; " + currentBlock.previousHash);
                console.log("Previous block: " + previousBlock.hash + " ; " + previousBlock.previousHash);

                if (currentBlock.hash != currentBlock.calculateHash()) {
                    return false;
                }

                if (currentBlock.previousHash != previousBlock.hash) {
                    return false;
                }
            }
            return true;
        }
}


let adsbTrack = new Blockchain();

adsbTrack.createLocalization(new Localization('icao1', 'icao2', 1, 34.620919, 112.452880, 5196.9));
adsbTrack.createLocalization(new Localization('icao1', 'icao2', 1, 34.620919, 112.452880, 5191.9));

console.log('\nStarting the tracker-1...');
adsbTrack.minePendingLocalizations('ground-station-address-1');
console.log('\nBalance of ground-station-1 is ', adsbTrack.getBalanceOfAddress('ground-station-address-1'));
console.log('\nStarting the tracker-1 again ...');
adsbTrack.minePendingLocalizations('ground-station-address-1');
console.log('\nBalance of ground-station-1 is ', adsbTrack.getBalanceOfAddress('ground-station-address-1'));

adsbTrack.createLocalization(new Localization('icao1', 'icao2', 1, 34.620919, 112.452880, 5186.9));
adsbTrack.createLocalization(new Localization('icao1', 'icao2', 1, 34.620919, 112.452880, 5181.9));

console.log('\nStarting the tracker-2...');
adsbTrack.minePendingLocalizations('ground-station-address-2');
console.log('\nBalance of ground-station-2 is ', adsbTrack.getBalanceOfAddress('ground-station-address-2'));
console.log('\nStarting the tracker again ...');
adsbTrack.minePendingLocalizations('ground-station-address-2');
console.log('\nBalance of ground-station-2 is ', adsbTrack.getBalanceOfAddress('ground-station-address-2'));

console.log('\nIs blockchain valid? ' + adsbTrack.isChainValid() + '\n');

console.log(JSON.stringify(adsbTrack, null, 4));