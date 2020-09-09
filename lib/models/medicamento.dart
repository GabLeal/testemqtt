import 'package:dio/dio.dart';
import 'package:prevent/global.dart' as glob;


class Medicamento{
  final int id;
  final String txNome;
  final DateTime dtInicio;
  final DateTime dtFim;
  final int nrQuantidade;
  final String txUtilizacao;
  final String txTipoMedicamento;
  final String txDiasSemana;
  final int nrIntervaloDoses;
  final String nrDoses;
  final String cdTransaction;

  Medicamento({
    this.id,
    this.txNome,
    this.dtInicio,
    this.dtFim,
    this.nrQuantidade,
    this.txUtilizacao,
    this.txTipoMedicamento,
    this.txDiasSemana,
    this.nrIntervaloDoses,
    this.nrDoses,
    this.cdTransaction
  });


  void buscaMedicamentoAgenda(cdPessoa, data)async{
    Dio http = Dio();
    Response response;
    
    response = await http.post(
      "${glob.link}medicamento/agenda/busca",
        data: {
          "cd_pessoa": cdPessoa,
          "dt_atual": data.toString().substring(0, 10)
        }
    );
  }


}
