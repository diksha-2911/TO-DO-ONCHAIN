import {ethers} from 'ethers';

import * as Constants from "../../utils/config";


async function handler (req, res) {
    try {
        const id = req.body;
        const provider = new ethers.providers.JsonRpcProvider(Constants.API_URL);
        const signer = new ethers.Wallet(Constants.PRIVATE_KEY, provider);
        const contract = new ethers.Contract(Constants.CONTRACT_ADDRESS, Constants.CONTRACT_ABI, signer);
        const tx = await contract.markAsFinished(id);
        await tx.wait();

        res.status(200).json({message : "Task has been changed to finished"});
    }

    catch (err) {
        console.error(err);
    }
}

export default handler;