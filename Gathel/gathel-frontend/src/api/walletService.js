import api from "./api";

export const obtenerBilleteras = async () => {

    const response =
        await api.get("/wallets");

    return response.data;
};