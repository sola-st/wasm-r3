# Hello World NPM

This is an example project to see the minimal amount effort needed to publish to NPM.

![Example CL Usage](example.gif)

## Installation

```
npm install -g nimstall
nimstall -g hello-world-npm
```

## Usage

### In Your Source Code

```
import { helloWorld } from 'hello-world-npm';

console.log(helloWorld());

```

OR

```
import HelloWorldNPM from 'hello-world-npm';

console.log(HelloWorldNPM.helloWorld());

```

OR

```
import HelloWorldNPM from 'hello-world-npm';

console.log(HelloWorldNPM());

```

### Command Line

```
hello-world-npm
```
