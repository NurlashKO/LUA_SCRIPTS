#ifndef __EBDAT_SOCK_DEF_H__
#define __EBDAT_SOCK_DEF_H__
typedef enum
{
    EBDAT_PS_OP_RESULT_SUCCESS,
    EBDAT_PS_OP_RESULT_WOULDBLOCK,
    EBDAT_PS_OP_RESULT_FAILED,
    EBDAT_PS_OP_FAILED_PEER_SOCK_CLOSE//only valid for ebdat_sock_recv()
}ebdat_ps_op_result_e_type;

#define EBDAT_PS_ENETISCONN           200 /* subsystem established and available */
#define EBDAT_PS_ENETNONET            202       /* network subsystem unavailable */

#define INVALID_SOCK_HANDLE           -1

#define EBDAT_SOCK_WRITE_EVENT  0x01         /* associated with a writeable socket */
#define EBDAT_SOCK_READ_EVENT   0x02          /* associated with a readable socket */
#define EBDAT_SOCK_CLOSE_EVENT  0x04         /* associated with a closeable socket */
#define EBDAT_SOCK_ACCEPT_EVENT 0x08        /* associated with an accetable socket */


typedef void (*ebdat_ps_op_net_cb_fcn)
(
  int16            nethandle,                               /* Application id */
  uint32 iface_id,                    /* reserved */
  int16            errno, /* type of network error, EBDAT_PS_ENETISCONN, EBDAT_PS_ENETNONET.*/
  void            * net_cb_user_data               /* Call back User data  */
);

typedef void (*ebdat_ps_sock_cb_fcn)
(
  int16 nethandle,                                          /* Application id */
  int16 sockfd,                                      /* socket descriptor */
  uint32 event_mask,                                     /* Event occurred */
  void * sock_cb_user_data       /* User data specfied during registration */
);

ebdat_ps_op_result_e_type ebdat_ps_open_ps_network
(
  uint8 cid, 
  ebdat_ps_op_net_cb_fcn net_cb_func, 
  void* net_cb_user_data,
  ebdat_ps_sock_cb_fcn sock_cb_func,
  void* sock_cb_user_data, 
  sint15* net_handle_ptr/*output*/
);
ebdat_ps_op_result_e_type ebdat_ps_close_ps_network(int16 net_handle);
ebdat_ps_op_result_e_type ebdat_ps_release_ps_netlib(int net_handle);


typedef enum
{
  EBDAT_IPPROTO_IP   = 1,               /* IP protocol level                 */
  EBDAT_SOL_SOCKET   = 2,               /* socket level                      */
  EBDAT_SOCK         = EBDAT_SOL_SOCKET,  /* another alias for socket level    */
  EBDAT_IPPROTO_TCP  = 3,               /* TCP protocol level                */
  EBDAT_IPPROTO_IPV6 = 4,               /* IPV6 protocol level               */
  EBDAT_IPPROTO_ICMP  = 5,               /* ICMP protocol level              */
  EBDAT_IPPROTO_ICMP6 = 6                /* ICMPv6 protocol level            */
} ebdat_sockopt_levels_type;

typedef enum
{
  EBDAT_SOCKOPT_MIN     = -1,        /* lower bound                          */
  EBDAT_IP_TTL          =  0,        /* time-to-live                         */
  EBDAT_SO_SYS_SOCK     =  1,        /* bool: is this a system socket?       */
  EBDAT_SO_SILENT_CLOSE =  2,        /* bool: close() call causes conn reset */
  EBDAT_SO_RCVBUF       =  3,        /* set the receive window size          */
  EBDAT_SO_LINGER       =  4,        /* linger on close                      */
  EBDAT_SO_SNDBUF       =  5,        /* set/get the sndbuf queue size        */
  EBDAT_TCP_MAXSEG      =  6,        /* set/get the TCP maximum segement size*/
  EBDAT_SO_SDB_ACK_CB   =  7,        /* call a cb upon recv'ing SDB data ack */
  EBDAT_TCP_NODELAY     =  8,        /* Disable Nagle's algorithm            */
  EBDAT_SO_KEEPALIVE    =  9,        /* Send keepalive probes?               */
  EBDAT_SO_NETPOLICY    =  10,       /* get socket netpolicy                 */
  EBDAT_SO_TX_IFACE     =  11,       /* get tx iface id                      */
  EBDAT_TCP_DELAYED_ACK =  12,       /* Enable delayed ack                   */
  EBDAT_TCP_SACK        =  13,       /* Enable SACK                          */
  EBDAT_TCP_TIME_STAMP  =  14,       /* Enable TCP time stamp option         */
  EBDAT_BCMCS_JOIN      =  15,       /* Join m'cast group                    */
  EBDAT_BCMCS_LEAVE     =  16,       /* Leave m'cast group                   */
  EBDAT_IP_RECVIF       =  17,       /* Get incoming packet's interface      */
  EBDAT_IP_TOS          =  18,       /* Type of Service                      */
  EBDAT_IPV6_TCLASS     =  19,       /* Traffic class for V6 sockets         */
  EBDAT_SO_CB_FCN       =  20,       /* set the socket callback function     */
  EBDAT_SO_ERROR_ENABLE =  21,       /* Enable storage of ICMP err in so_err */
  EBDAT_SO_ERROR        =  22,       /* Get value of ICMP so_error           */
  EBDAT_SO_LINGER_RESET =  23,       /* Linger and reset on timeout          */
  EBDAT_IP_RECVERR      =  24,       /* Enable getting ICMP error pkts       */
  EBDAT_IPV6_RECVERR    =  25,       /* Enable getting ICMPv6 error pkts     */
  EBDAT_TCP_EIFEL       =  26,       /* Enable EIFEL Algorithm               */
  EBDAT_SO_QOS_SHARE_HANDLE = 27,    /* QOS group handle                     */
  EBDAT_SO_REUSEADDR    =  28,       /* Enable Socket Reuse                  */
  EBDAT_SO_DISABLE_FLOW_FWDING =  29,/* Disable forwarding data on best effort
                                      flow if QoS flow can't be used       */
  EBDAT_ICMP_ECHO_ID      = 30,      /* ICMP ECHO_REQ message, identifier    */
  EBDAT_ICMP_ECHO_SEQ_NUM = 31,      /* ICMP ECHO_REQ message, sequence num  */
  EBDAT_IP_ADD_MEMBERSHIP = 32,      /* Requests that the system join a
                                      multicast group                      */
  EBDAT_IP_DROP_MEMBERSHIP = 33,     /* Allows the system to leave a multicast
                                      group                                */
  EBDAT_IP_MULTICAST_TTL = 34,       /* Specifies the time-to-live value for
                                      multicast datagrams sent through this
                                      socket                               */
  EBDAT_TCP_FIONREAD     = 35,       /* To get the TCP rcvq length           */
EBDAT_IP_LAST_RECEIVED_TOS = 36,   /* To get TOS value in the last received 
                                      IP packet. */
  EBDAT_SOCKOPT_MAX                  /* determine upper bound and array size */
} ebdat_sockopt_names_type;

ebdat_ps_op_result_e_type ebdat_sock_async_deselect
(
  int16 sock_fd,                       
  int32 event_mask                     
);

ebdat_ps_op_result_e_type ebdat_sock_async_select
(
  int16 sock_fd,                       
  int32 event_mask                     
);

int16 ebdat_sock_create(int16 nethandle, byte   family, byte   type,byte   protocol);

ebdat_ps_op_result_e_type ebdat_sock_connect(const int16 sfd, struct sockaddr_in * addr, const size_t saddrsiz);

ebdat_ps_op_result_e_type ebdat_sock_recv(const int16 sfd, byte* buf, uint32 len, int* bytes_recv_p);

ebdat_ps_op_result_e_type ebdat_sock_send(const int16 sfd, byte* buf, uint32 len, int* bytes_sent_p);

ebdat_ps_op_result_e_type ebdat_sock_recvfrom(const int16 sfd, byte* buf, uint32 len, int* bytes_recv_p, struct sockaddr_in* fromaddr_p);

ebdat_ps_op_result_e_type ebdat_sock_sendto(const int16 sfd, byte* buf, uint32 len, int* bytes_sent_p, struct sockaddr_in* destaddr_p);

ebdat_ps_op_result_e_type ebdat_sock_close(const int16 sfd);

ebdat_ps_op_result_e_type ebdat_sock_bind(const int16 sfd, struct sockaddr_in * addr, const size_t saddrsiz);

ebdat_ps_op_result_e_type ebdat_sock_listen(const int16 sfd);

int16 ebdat_sock_accept(const int16 sfd, struct sockaddr_in* peer_addr_p);

boolean ebdat_sock_setsockopt
(
  int sockfd,                            /* socket descriptor              */
  int level,                             /* socket option level      ====>  ebdat_sockopt_levels_type      */
  int optname,                           /* option name    ====>    ebdat_sockopt_names_type            */
  void *optval,                          /* value of the option            */
  uint32 *optlen                        /* size of the option value       */
);

boolean ebdat_sock_getsockopt
(
  int sockfd,                            /* socket descriptor              */
  int level,                             /* socket option level      ====>  ebdat_sockopt_levels_type      */
  int optname,                           /* option name            ====>    ebdat_sockopt_names_type         */
  void *optval,                          /* value of the option            */
  uint32 *optlen                       /* size of the option value       */
);

boolean ebdat_sock_get_sock_name(int16 sfd, struct sockaddr* addr_p, uint16* addrlen_p);

typedef void (*ebdat_dns_event_callback_fcn)(uint32 ip_addr, boolean suc, void* user_data);
ebdat_ps_op_result_e_type ebdat_dns_get_host_entry(const char *const host,  struct in_addr *const ip_address, ebdat_dns_event_callback_fcn dns_cb, void* user_data);
#endif /* __EBDAT_SOCK_DEF_H__ */
