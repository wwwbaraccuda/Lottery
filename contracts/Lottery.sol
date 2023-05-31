pragma solidity >=0.7.0 <0.9.0;

contract Lotere {
    address manager;
    address[] peserta;
    address payable penerima;
    uint index;

    function deployContract() private {
        manager = msg.sender;
    }

    function inputUang() public payable {
        require(msg.value> .01 ether, "Tidak cukup uang");
        peserta.push(msg.sender);
    }

    function angkaRandom() private view returns(uint) {
        return uint(keccak256(abi.encodePacked(block.prevrandao, block.timestamp, peserta)));
    }

    modifier managerOnly() {
        require(msg.sender == manager, "Harus manager yang memilih");
        _;
    }

    function pilihPemenang() public managerOnly {
        index = angkaRandom() % peserta.length;
        penerima = payable (peserta[index]);
        penerima.transfer(address(this).balance);
    }
    function tampilkanPemenang() public view returns(address) {
        return(penerima);
    }

    function tampilkanPeserta() public view returns(address[] memory) {
        return(peserta);
    }

}
