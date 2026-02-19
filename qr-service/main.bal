import ballerina/http;

service / on new http:Listener(9090) {

    // Serve stored QR images
    resource function get qr/[string fileName]() returns string {
        // In a real app, you'd fetch and return the actual QR image or file
        return fileName;
    }

    // Health check endpoint
    resource function get health() returns json {
        return { status: "UP" };
    }
}
