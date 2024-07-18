---
title: "Please stop using SemVer for Blockchains"
date: 2024-07-18T00:00:00+00:00
author: Spoorthi Satheesha
layout: post
permalink: /please-stop-using-semver-for-blockchains/
categories: Opinion
tags: [blockchain, cosmos]
---

Note: This post is writted with Cosmos-SDK based blockchains in mind.

Most Cosmos blockchains, as of the time of this post, "use" Semver for tagging their code releases. Or, Semver-presenting versioning.
Before I elaborate, here is the summary of what Semver is, taken straight from their [website](https://semver.org/).

```
 Given a version number MAJOR.MINOR.PATCH, increment the:
 MAJOR version when you make incompatible API changes
 MINOR version when you add functionality in a backward compatible manner
 PATCH version when you make backward compatible bug fixes
    Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.
```

Diving into the Major version, Semver says "increment MAJOR version when you make incompatible API changes". That sounds straightforward. To follow it, we should bump the major version when we make any Proto API changes. But it also uses the word **incompatible**. Incompatibility in Web2 systems is easy, no one else knows or cares what backend you are running as long as the API contracts aren't broken. But blockchains care. A smol lil teeny tiny line of code can change the amount of gas consumed in a transaction, which is then merkelized. Basically, anything which changes the execution can break consensus. The binaries can be incompatible, whether APIs modified or not. 

Actually, APIs can be modified while binaries can stay compatible. How? The query service. Any node can add a new Query, which reads from state, and now the binaries are different, but the consensus is compatible. This wont hold true if a smart contract is relying on that query or if a transaction relies on that query internally, or [ICQ](https://github.com/cosmos/ibc/tree/main/spec/app/ics-031-crosschain-queries). But if its just a query, unused by other parts of the codebase, which is just to be used by end users or sidecars like indexers, its totally fine. Its not consensus breaking, even though it is API breaking.

And now, lets talk upgrade handlers. Cosmos chains might undergo a chain upgrade, where the state machine stays the same. What the upgrade is doing is modifying the state. E.g [Veritas](https://github.com/CosmosContracts/juno/blob/v5.0.1/app/upgrade/upgrade_handler.go) upgrade of Juno which was used to send funds from one address to another. The state machine compatibility is maintained but if a validator does not apply the upgrade handler, their state is broken. Also, just to note, the upgrade handlers require an [identifier](https://github.com/cosmos/cosmos-sdk/blob/v0.47.5/proto/cosmos/upgrade/v1beta1/upgrade.proto#L26) to register the upgrade with, which need not match the tagged version of the code. Some chains use a [human-friendly/marketing-friendly](https://github.com/noble-assets/noble/blob/v4.1.3/app/upgrades/fusion/constants.go#L4) name, some use the [full version](https://github.com/archway-network/archway/blob/main/app/upgrades/4_0_2/upgrades.go#L16), some use just the [major version](https://github.com/CosmosContracts/juno/blob/main/app/upgrades/v10/constants.go#L13).


Coming to the Minor and Patch version, Semver says to use them for backwards compatible features and bugs respectively. While having these two as distinct items might make sense for APIs, for a blockchains, likely not. Any new feature will likely be consensus breaking, same with any bug fixes too. Only backwards compatible features/bugs which are are possible are in the node's CLI code or protocol events thrown. These changes are optional to apply, as they arent consensus or state breaking. 

Now lets talk testnets and devnets. I firmly believe that testnet should mirror mainnet in everything except state. State transition functions should match. Upgrade handlers should be the same. So, that makes it pretty straightforward. Any versioning scheme which would work for mainnet, should work for testnet.
But how about devnets? Semver allows suffixes like alpha, beta etc. Honestly, among everything else, I am not super against this. However, there can be better ways to handle this. e.g if you are on v2.0.0 and you are prepping for v3 and tag v3.0.0-beta.1 and deploy on devnet with the upgrade handler, but turns out the upgrade is broken, would you tag v3.0.0-beta.2 next? Would you re-run the upgrade handler? Would your answer change if the broken upgrade was due to upgrade handler logic or if due to some other part of the codebase? 

Final edge case we need to discuss are the security incidences. For semver, its easy. Its a patch fix. But if this security issue is so major that you need to patch it (see what i did there 😉), its likely that its consensus breaking. e.g [Huckleberry](https://forum.cosmos.network/t/ibc-security-advisory-huckleberry/10731) required patching ibc-go and most chains only bumped up their [patch version](https://github.com/osmosis-labs/osmosis/releases/tag/v15.1.2). So, if a new node operator, expecting that a patch is meant to be non-breaking and used an older tag, their node would fail consensus. Lets be serious, we cant use Patch for both consensus breaking security fixes and also for minor cli changes. 

Based on these, one could say, here is a simple solution, lets just never use the Patch. Lets increment,
1. MAJOR when there is either consensus/state breaking change (or anything which goes via MsgSoftwareUpgrade) + Security Fixes
2. MINOR when there is a change which doesnt break consensus or state

And this would almost work. If the only people who cared about the version were the validators and node runners, then yes, this would suffice. They would know what this means. But unlike web2, where the only ones who care about the version are a homogenous set of API consuming developers, in web3, along with validators, we have relayers and non-validating node operators. And there are smart contract devs, the frontend devs, and the wallet devs. All of these stakeholders care about different things. A smart contract dev doesnt care about consensus compatibility but about APIs. An indexer might care about all things we have mentioned. An RPC node operator might care about none of these explicitly if they are letting cosmovisor upgrade the binaries on their behalf. Finally, even the token holders of the chain should care. Anybody who votes on a governance proposal needs to be able to understand what they are voting on. Even Semver says "version numbers and the way they change convey meaning about the underlying code". With such a diverse set of situations a blockchain upgrade could end up in, what is it that we are conveying about the underlying code when we try to use semver? Without compliance to some sort of formal specification, version numbers are essentially useless.

Is there a solution to this? I have some ideas. Some simple, some too radical to be honest. We need to let go of the current socially acceptable beauty standard of a version tag looking like `vX.X.X`. We need something far different from that. If there is enough interest, I will write another post where I go into it.