---
title: "Handling Type Definition Errors in Typescript"
date: 2019-08-06T00:00:00+00:00
author: Spoorthi Satheesha
layout: post
permalink: /handling-type-definition-errors-in-typescript
categories: Programming
tags: [typescript]
excerpt: "Guide on how to handle Type Definition Errors in Typescript"
seo_title: "Handling Type Definition Errors in Typescript"
seo_description: "Guide on how to handle Type Definition Errors in Typescript"
---


If you have ever used Typescript and tried to install and use an npm package, you can find yourself in one of the three scenarios.

- The npm package exposes a *package.d.ts*, and you can import the package and use it as is.

- The npm package doesn’t export the type definitions, but you can try `npm install @types/package` and find the required type definitions.

- If you still can’t find type definitions, you can write your own type definitions.

Example:

For a project, I had to use [**vue-star-rating**](https://www.npmjs.com/package/vue-star-rating/v/1.6.1) npm package. The package doesn’t export any type definitions and `@types/vue-star-rating` does not exist.

If you try to use a package which does not have a type definition, Typescript gets a little worried; and justifiably so. Ideally, you will have to write your own *package.d.ts* to handle this. However, if you are working on a prototype and are okay with forgoing type safety, you can simply save this as *package.d.ts*.

```typescript

declare module "vue-star-rating" {
    var StarRating: any;
    export = StarRating;
}

```

This will help you fix those compilation errors and let you use the package without going through the package source code and writing your own definitions.

Even if the package does export the required `package.d.ts`, you might still end up with compilation errors.

Example:

For a project, I had to use [**timeago.js**](https://www.npmjs.com/package/timeago.js/v/4.0.0-beta.2) npm package. The package exports a `timeago.d.ts`. However, the package internally has reference to JQuery. I didn’t require the functionality from the package which used JQuery. So either I had to install JQuery with its types or I could skip library type checking during compilation.

```sh

Error in ../node_modules/../package.d.ts
9666:21 Cannot find name ‘Jquery’.

```

![Cannot find name jquery](/assets/images/posts/2019-08-06-Handling-Type-Definition-Errors-In-Typescript/timeago.png "Cannot find name jquery")

```sh

Error in ../node_modules/../package.d.ts
7318:91 Cannot find name ‘Buffer’. Do you need to install type definitions for node? Try
npm i @types/node and then add node to the types field in your tsconfig

```

![Cannot find name buffer](/assets/images/posts/2019-08-06-Handling-Type-Definition-Errors-In-Typescript/node.png "Cannot find name buffer")

To skip the external library type checking, you can set the *skipLibCheck* value to true in *tsconfig.json*
