export const copyObject = <T = any>(obj: T) => JSON.parse(JSON.stringify(obj)) as T;
