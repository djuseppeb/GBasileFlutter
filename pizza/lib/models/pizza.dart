class Pizza{
  final String nome;
  final String id;

  Pizza(this.nome, this.id);

  static List<Pizza> get listaPizze {
    return [
      Pizza('Marinara', '01'),
      Pizza('Margherita', '02'),
      Pizza('Prosciutto e funghi', '03'),
      Pizza('Diavola', '04'),
      Pizza('Quattro stagioni', '05'),
      Pizza('Quattro formaggi', '06'),
      Pizza('Vegetariana', '07'),
      Pizza('Capricciosa', '08'),
      Pizza('Viennese', '09'),
      Pizza('Sole', '10'),
    ];
  }
}