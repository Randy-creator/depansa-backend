# SignInResult

## Properties

| Name      | Type                            |
| --------- | ------------------------------- |
| `account` | [SignUpResult](SignUpResult.md) |
| `token`   | string                          |

## Example

```typescript
import type { SignInResult } from "";

// TODO: Update the object below with actual values
const example = {
  account: null,
  token: null,
} satisfies SignInResult;

console.log(example);

// Convert the instance to a JSON string
const exampleJSON: string = JSON.stringify(example);
console.log(exampleJSON);

// Parse the JSON string back to an object
const exampleParsed = JSON.parse(exampleJSON) as SignInResult;
console.log(exampleParsed);
```

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)
