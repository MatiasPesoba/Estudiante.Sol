// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Colegio {

    // Variables Pedidas
    string private _Nombre;
    string private _Apellido;
    string private _Curso;
    address private _Docente;
    mapping (string => uint8) private Notas_Materia;
    string [] private _Nom_Materias;

    // Constructor con sus variables
    constructor(string memory Nombre_, string memory Apellido_, string memory Curso_) {
        Nombre = Nombre;
        Apellido = Apellido;
        Curso = Curso;
        _Docente = msg.sender;
    }

    //Devuelve apellido del alumno y public view es para que se pueda ver
    function apellido() public view returns (string memory) {
        return _Apellido;
    }

    // public pure es para que no lea ni modifica las variables
    function AppendString(string memory a, string memory b, string memory c) public pure returns (string memory) {
        return string(abi.encodePacked(a,b,c));
    }

    //Devuelve nombre completo del alumno se usa el AppendString para concatenar strings
    function nombre_completo() public view returns (string memory) {
        return AppendString(_Nombre, " ", _Apellido);
    }

    //Duevuele el curso de dicho alumno
    function curso() public view returns (string memory) {
        return _Curso;
    }

    //Permite que los docentes pongan las notas de la materia
    function Set_Nota_Materia(uint8 _Nota, string memory _Materia) public {
        require(_Docente == msg.sender, "No podes camibiar la nota Gil");
        require(_Nota <= 100 && _Nota >= 1, "No es una nota valida");
        Notas_Materia[_Materia] = _Nota;
        _Nom_Materias.push(_Materia);
    }

    //Devuelve la nota de la materia dependiendo de que materia quieras
    function Nota_Materia(string memory _Materia) public view returns (uint) {
        uint _Nota = Notas_Materia[_Materia];   
        return _Nota;
    }
    
    //Mira si la nota es mayor o igual a 60%(60/100), devuelve true o false dependiendo de si es mayor a 60% o no
    function Aprobo(string memory _Materia) public view returns (bool) {
        require (Notas_Materia[_Materia] >= 60);
        return true;
       
    }

    //hace el promedio de
    function promedio() public view returns (uint) {

        uint _CantItems = _Nom_Materias.length;
        uint _NotaParaPromedio;
        uint _NotaFinal;

        for (uint i = 0; i < _CantItems; i++){
            _NotaParaPromedio += Notas_Materia[_Nom_Materias[i]];
        }

        _NotaFinal = _NotaParaPromedio / _CantItems;
        return _NotaFinal;
    
    }
}