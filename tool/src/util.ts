export function unreachable(value: never) {
    throw new Error('This never throws, you cant call this function anyway')
}