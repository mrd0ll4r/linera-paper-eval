# Linera Paper Eval

Evaluation code for Linera.

## Building

The build process is automated in Docker.
It builds both a recent linera validator/storage server/... and the evaluation binaries.

You will need

- A Linux machine
- Docker
- A storage engine for docker that supports caching (e.g. the `containerd` storage driver)
- A lot of disk space for the Linera build, probably on the order of 100GB

Then, build using

```bash
./build_docker_paper_eval_binaries.sh
```

Alternatively, you can also build manually.

## Running

The experiments are set up in a way to put databases, wallets, etc. into a directory at `/ramdisk`,
and output data into a directory at `/data_out`.
By default, these are mounted as volumes at `/media/ramdisk` and `./data_out` on the host.
The experiments are controlled via environment variables, see `run_docker_paper_eval.sh`.

After building, run the experiments in Docker using

```bash
./run_docker_paper_eval.sh
```

this will run the experiments.
Each experiment starts a Linera network in a specific configuration and executes the benchmark against it.
Results will be stored in `data_out/`, owned by a user with UID 1000.

## TODO

- We need to untangle the evaluation client from the node and the Docker setup.
  This should be pretty easy, just build the eval client binary, extract it, point it at the RAMdisk and the fountain,
  and stuff should work. It'll need a few non-hardcoded parameters, but it should be doable.
  Alternatively, we could also provide the admin wallet (which contains the genesis config) instead of the fountain.
- We can probably get rid of the chain balancing, and maybe even the balance checking, once we're sure that
  things work correctly.
  This will save us a lot of time on the benchmarks.
- Something about the inbox processing or something is flaky.
    This shows when querying balances sometimes. Something about different order of things.
- Instead of passing around `(ChainDescription, AccountOwner)`, we should probably pass around `ChainClient`s and maybe `ChainId`s.
- We create the chains from the fountain, which works, but is a bit slow and weird.
    The `linera benchmark` implementation does this much nicer, and I think we can do the same.
    For that to work we need to use the admin wallet, and then a bunch of methods on the `ClientContext` or something.
    I found that the only combination of wallets and keystores that are created that works is
    `keystore_1.json`, `wallet_1.json`, and `client_0.db`. No clue why.
- The startup script probably does some useless stuff, like creating the second wallet.
    Then again, that wallet and keystore work with `linera benchmark`, whereas the first wallet and keystore don't.
- The variable load experiments currently operate in three phases:
    1. 30 seconds of `k` chains at `target_bps` blocks per chain with `num_tx` in each block.
    2. 30 seconds of `k` additional chains at `target_bps` blocks per chain with `num_tx` in each block.
    3. 30 seconds without the additional chains, i.e., back to the first phase.
    
    This works, but is not that flexible. Maybe we want something else than double the load at some point.
    The implementation is flexible enough, we just need to specify it, and name the output directories in a way that makes sense.
- The entire data I/O situation of the tool is pretty bad at the moment.
    We should create a few structs that represent the data we need to store, instead of passing around tuples etc.
- The `linera benchmar` implementation is much nicer, we could copy that and add something to export the features we need,
    but I found that it sometimes behaves weirdly under load, so I'd like to keep the current implementation.
- The `linera benchmark` implementation uses a `ChainListener`.
    I don't know if we need that, I don't know if we're somehow already using it under the hood, no clue.
- We could make the client lighter, maybe. This will make things faster, probably.
- I have no idea if we should close the chains at the end of the benchmark (doesn't matter, the network is killed anyway),
    or maybe even in between experiments, and use fresh chains.
    At some point the chains will become quite long, which is probably bad.
    I ran into trouble because the fountain runs dry at some point, we could fix this with the method `linera benchmark`
    uses to create chains, because they can give them a custom (smaller) starting balance,
    which seems to be impossible via the fountain (?).
- It is possible to run a Linera validator against ScyllaDB on RAMdisk if we enable `--developer-mode 1`.
    The performance of this is unclear, to be tested, but close to a real deployment, I guess.
