# PaginationResult

## Properties

| Name        | Type    |
| ----------- | ------- |
| `totalPage` | number  |
| `page`      | number  |
| `hasNext`   | boolean |
| `hasPrev`   | boolean |

## Example

```typescript
import type { PaginationResult } from "";

// TODO: Update the object below with actual values
const example = {
  totalPage: null,
  page: null,
  hasNext: null,
  hasPrev: null,
} satisfies PaginationResult;

console.log(example);

// Convert the instance to a JSON string
const exampleJSON: string = JSON.stringify(example);
console.log(exampleJSON);

// Parse the JSON string back to an object
const exampleParsed = JSON.parse(exampleJSON) as PaginationResult;
console.log(exampleParsed);
```

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)
