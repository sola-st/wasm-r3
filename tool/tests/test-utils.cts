import fs from 'fs'

export function getDirectoryNames(folderPath: string) {
    const entries = fs.readdirSync(folderPath, { withFileTypes: true });

    const directories = entries
        .filter((entry) => entry.isDirectory())
        .map((entry) => entry.name);

    return directories;
}