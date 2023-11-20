import readline from 'readline'

export function unreachable(value: never) {
    throw new Error('This never throws, you cant call this function anyway')
}

export async function askQuestion(question: string) {
    const rl = readline.createInterface({
        input: process.stdin,
        output: process.stdout,
    });
    return new Promise((resolve) => {
        rl.question(question, (answer) => {
            rl.close()
            resolve(answer);
        });
    });
}