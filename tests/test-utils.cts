import fs from 'fs/promises'
import path from 'path'

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

export async function copyDir(source: string, destination: string) {
    await fs.mkdir(destination, { recursive: true });
    const items = await fs.readdir(source, { withFileTypes: true });
    for (const item of items) {
        const srcPath = path.join(source, item.name);
        const destPath = path.join(destination, item.name);
        if (item.isDirectory()) {
            await copyDir(srcPath, destPath);
        } else {
            await fs.copyFile(srcPath, destPath);
        }
    }
}

export function trimFromLastOccurance(str: string, substring: string) {
    const lastIndex = str.lastIndexOf(substring);
    if (lastIndex === -1) {
        // Substring not found, return original string or handle as needed
        return str;
    }
    return str.substring(0, lastIndex + substring.length);
}

export function writeWithSpaces(name: string) {
    const totalLength = 45;
    if (totalLength < name.length) {
        throw new Error("Total length should oe greater than or equal to the length of the initial word.");
    }
    const spacesLength = totalLength - name.length;
    const spaces = " ".repeat(spacesLength);
    process.stdout.write(`${name}${spaces}`)
}

export async function findWatNames(dirPath: string) {
    let files = await fs.readdir(dirPath);
    return files.filter(f => path.parse(f).ext === ".wat");
}