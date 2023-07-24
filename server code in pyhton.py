import socket

HOST = "192.168.50.111"                 # Laptop's IP address (change this to your laptop's IP)
PORT = 5201                             # Server port to listen on
BUFFERSIZE = 1024                       # Buffer size for receiving data

# Create a UDP socket
UDPServerSocket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

# Bind the socket to the server address and port
UDPServerSocket.bind((HOST, PORT))

print("UDP Server is up and listening on {0}:{1}".format(HOST, PORT))

while True:
    # Receive data from the NodeMCU
    data, client_address = UDPServerSocket.recvfrom(BUFFERSIZE)
    
    print("Received data:", data.decode('utf-8'))



    # Save the received data to a file
    with open('received_file.txt', 'ab') as file:
        file.write(data)

    # Send a response back to the NodeMCU
    response_message = "Data received successfully!"
    UDPServerSocket.sendto(response_message.encode('utf-8'), client_address)
    print("Response sent to NodeMCU")
