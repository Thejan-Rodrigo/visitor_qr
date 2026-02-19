import ballerina/http;

service / on new http:Listener(9090) {

    // Serve stored QR images
    resource function get qr/[string fileName]() returns string {
        return fileName;
    }
}