function helloWorld() {
	return "Hello World"
}

function HelloWorldNPM() {
	return "Hello World NPM"
}

module.exports = HelloWorldNPM;
HelloWorldNPM.helloWorld = helloWorld;