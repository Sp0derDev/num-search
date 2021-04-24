class QueryResponse {
  final bool sucess;

  final String errorMessage;
  final String infoMessage;
  final result;
  QueryResponse(
      {this.sucess, this.errorMessage, this.infoMessage, this.result});
}
