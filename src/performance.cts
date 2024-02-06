import fs from 'fs/promises'
import { rmSafe } from '../tests/test-utils.cjs'

type PerformanceInfo = {
    phase: 'record' | 'replay-generation' | 'replay' | 'all',
    description: string
}

export type StopMeasure = () => PerformanceMeasure
export function createMeasure(name: string, detail: PerformanceInfo): StopMeasure {
    const start = name + 'start'
    const end = name + '_end'
    performance.mark(start)
    return () => {
        performance.mark(end)
        return performance.measure(name, { start, end, detail })
    }
}

type Type = 'manual-run' | 'offline-auto-test' | 'online-auto-test' | 'node-auto-test'
export async function initPerformance(app: string, type: Type, filePath?: string) {
    const timeStamp = Date.now()
    const dBPath = 'performance.db.ndjson'
    await rmSafe(filePath)
    const measureCallback: PerformanceObserverCallback = async (list) => {
        for (let measure of list.getEntriesByType('measure')) {
            //@ts-ignore for some reason I cannot cast measure of type PerformanceEntry to PerformanceMeasure
            const entry = { ...measure.toJSON(), ...measure.detail }
            fs.appendFile(dBPath, JSON.stringify({ timeStamp, url: app, type, ...entry }) + '\n')
            if (filePath !== undefined) {
                fs.appendFile(filePath, JSON.stringify(entry) + '\n')
            }
        }
    }

    const observer = new PerformanceObserver(measureCallback)
    observer.observe({ type: 'measure' })
    return () => observer.disconnect()
}