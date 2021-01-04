## Socket Programming
### HTTP vs Socket
#### HTTP
- Client 의 Request 가 있는 경우에만, Server 의 Response 를 받을 수 있다.
- Server 는 Request 를 보낼 수 없다.
- Server 는 해당 Request 의 Response 만 전달 후, 연결을 종료 한다.
- Content 위주의 Data 를 사용할 때, 유용한 방식.

#### Socket
- Server 와 Client 가 특정 Port 를 통해 연결 하여, 양방향 통신을 하는 방식.
- Server 도 Request 를 보낼 수 있다.
- 실시간으로 연결이 유지 된다.
- 실시간으로 양방향 정보 교환이 필요한 경우, 유용한 방식.
- 실시간 스트리밍 서비스에 적합.

> 만약 실시간 스트리밍 서비스를 HTTP 통신으로 구현 한다면, 스트리밍이 종료 될 때까지, Client 가 Server 로 요청을 지속적으로 보내야 함.


### TCP vs UDP
#### TCP(Transmissoin Control Protocol)
- ACK 를 사용 하여, 안정적으로 데이터가 전송 되지 못한 경우, 재전송 하여 정상적인 데이터를 전달 할 수 있도록 함.
- Client 가 연결 되어 있지 않으면, 전송 하지 않음.
- 안정성은 좋지만, 속도가 느림.

#### UDP(User Datagram Protocol)
- 데이터가 정상적으로 전달 되었는 지 확인 하지 않고 전송(데이터의 유실이 발생 할 수 있음).
- Client 접속 유뮤에 상관 없이 데이터 전송.
- 속도가 빠르지만, 안정성을 보장 할 수 없음.


### Socket Server vs Socket Client
#### Socket Server
1. 소켓 생성
2. 주소와 포트 할당
3. 요청 대기
4. 연결 수락

#### Socket Client
1. 소켓 생성
2. 연결 요청
