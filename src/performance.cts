export class PerformanceEntry {
    private name: string
    private duration: number
    private startTime: number
    private endTime: number

    constructor(name: string) {
        this.startTime = Date.now()
        this.name = name
    }

    buildFromObject(obj: any) {
        this.duration = obj.duration
        this.startTime = obj.startTime
        this.endTime = obj.endTime
        return this
    }

    stop() {
        this.endTime = Date.now()
        this.duration = this.endTime - this.startTime
        return this
    }

    toString() {
        return `${this.name}: ${this.duration}`
    }
}

export class PerformanceList {
    private events: PerformanceEntry[]
    private name: string

    constructor(name: string) {
        this.name = name
        this.events = []
    }

    push(entry: PerformanceEntry) {
        this.events.push(entry)
    }

    top() {
        return this.events[this.events.length - 1]
    }

    toString() {
        let eventList = ''
        for (let event of this.events) {
            eventList += event.toString() + '\n'
        }
        return `${this.name}\n${eventList}`
    }
}