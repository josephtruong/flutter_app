
class ApiResponse<T> {
  Status status;
  T data;
  String message;

  ApiResponse.completed(this.data) : status = Status.COMPLETE;

  ApiResponse.loading(this.message): status = Status.LOADING;

  ApiResponse.error(this.message): status = Status.ERROR;

  @override
  String toString() {
    return 'Status $status \n Message $message \n Data $data';
  }
}

enum Status { LOADING, COMPLETE, ERROR }
