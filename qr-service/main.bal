import ballerina/http;

service / on new http:Listener(8080) {

    // Serve stored QR images
    resource function get qr/[string fileName]() returns string {
        return fileName;
    }
}