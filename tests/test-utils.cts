import fs from 'fs/promises'

export async function getDirectoryNames(folderPath: string) {
    const entries = await fs.readdir(folderPath, { withFileTypes: true });

    const directories: string[] = entries
        .filter((entry) => entry.isDirectory())
        .map((entry) => entry.name);

    return directories;
}

export async function delay(ms: number) {
    return new Promise(resolve => {
        setTimeout(resolve, ms);
    });
}

export async function rmSafe(path: string) {
    try {
        await fs.rm(path, { recursive: true });
    } catch {
        // file doesnt exist, ok
    }
}


export function startSpinner(name: string) {
    const spinnerChars = ['|', '/', '-', '\\'];
    let spinnerIndex = 0;

    process.stdout.write(name + '   ');
    return setInterval(() => {
        process.stdout.write('\b')
        process.stdout.write(spinnerChars[spinnerIndex]);
        spinnerIndex = (spinnerIndex + 1) % spinnerChars.length;
    }, 130);
}

export function stopSpinner(interval: NodeJS.Timeout) {
    clearInterval(interval);
    process.stdout.write('\r')
}