import api from "./api";

export const obtenerProposiciones = async () => {

    const response =
        await api.get("/propositions");

    return response.data;
};

export const crearProposicion = async (data) => {

    const response =
        await api.post("/propositions", data);

    return response.data;
};