#include "gpu_merkle.h"
#include "sha256_gpu.h"
__global__ 
void mineKernel(char *header, int headerLen){
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    // each thread handles a consecutive pair of hashes
    if(i*2+1>=headerLen) return; // out of bounds
    //for hash indexing

    unsigned char* left = (unsigned char*) (header + (i * 2)*32);// left hash
    unsigned char* right = (unsigned char*) (header + (i * 2+1)*32); // right hash
    unsigned char * out = (unsigned char * )(header+i);// output slot (thread itself)
    //for calculating
    unsigned char combined_hashes[64];
    memcpy(combined_hashes, left, 32);
    memcpy(combined_hashes + 32, right, 32);

    //calling self created hashfunction to hash them together
    unsigned char hash_output[32]; // output of the hash function
    sha256_device(combined_hashes, 64, hash_output); // hash the combined hashes
    memcpy(out, hash_output, 32); // store resultant hash into thread id place
}

std :: string getMerkleRootGPU(std::vector <std::string>& merkle){ // function definition as per tko 22 standards
    std :: vector<std :: string> hashes = merkle; // start with the initial level of hashes
    if(hashes.size()%2!=0){ // incase of odd number of hashes
        hashes.push_back(hashes.back()); // duplicate the last hash
    }
    int numHashes=hashes.size();
    unsigned char h_hashes =. new unsigned char [numHashes*32];
    for (int i=0;i<numHashes;i++){
        memcpy(h_hashes+i*32, hashes[i].c_str(), 32); // copy the hashes into a continous memory
    }
    unsigned char *d_hashes;
    cudaMalloc(&d_hashes, numHashes*32); // allocate memory on the GPU





}