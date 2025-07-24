import React, { useRef, useState } from 'react';
import nutiImg from '../assets/nuti.png';
import nuti2Img from '../assets/Nuti2.png';

// PON TU API KEY DE OPENAI AQUÍ (¡nunca la subas a un repo público!)
const OPENAI_API_KEY = "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";

interface Message {
  sender: 'user' | 'bot';
  text: string;
}

export default function ChatBot() {
  const [messages, setMessages] = useState<Message[]>([
    { sender: 'bot', text: '¡Hola! 👋 Soy Nuti, la mascota virtual de BioNut 🥝✨. Estoy aquí para ayudarte con cualquier duda sobre el foro, la comunidad o hábitos saludables. ¡Cuéntame, en qué puedo ayudarte hoy!' }
  ]);
  const [input, setInput] = useState('');
  const [loading, setLoading] = useState(false);
  const chatEndRef = useRef<HTMLDivElement>(null);

  // Llama a la API de OpenAI
  async function sendToOpenAI(prompt: string, history: Message[]) {
    const systemPrompt = "Eres un asistente útil y amable para un foro de salud y nutrición. Responde de forma breve y clara.";
    const fullHistory = [
      { role: 'system', content: systemPrompt },
      ...history.map(m => ({ role: m.sender === 'user' ? 'user' : 'assistant', content: m.text }))
    ];
    const res = await fetch('https://api.openai.com/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${OPENAI_API_KEY}`
      },
      body: JSON.stringify({
        model: 'gpt-3.5-turbo',
        messages: [...fullHistory, { role: 'user', content: prompt }],
        max_tokens: 200,
        temperature: 0.7
      })
    });
    const data = await res.json();
    return data.choices?.[0]?.message?.content || 'Lo siento, no puedo responder en este momento.';
  }

  async function handleSend(e?: React.FormEvent) {
    if (e) e.preventDefault();
    if (!input.trim()) return;
    const userMsg: Message = { sender: 'user', text: input };
    setMessages(msgs => [...msgs, userMsg]);
    setInput('');
    setLoading(true);
    try {
      const botReply = await sendToOpenAI(input, [...messages, userMsg]);
      setMessages(msgs => [...msgs, { sender: 'bot', text: botReply }]);
    } catch {
      setMessages(msgs => [...msgs, { sender: 'bot', text: 'Hubo un error al conectar con el asistente.' }]);
    } finally {
      setLoading(false);
    }
  }

  const NUTI_AVATAR = nutiImg;

  return (
    <div className="w-full max-w-xl mx-auto bg-white/90 border border-emerald-200 rounded-2xl shadow-xl p-6 flex flex-col h-[500px]">
      <div className="flex-1 overflow-y-auto mb-4 pr-2">
        {messages.map((msg, i) => (
          <div key={i} className={`flex items-end ${msg.sender === 'user' ? 'justify-end' : 'justify-start'} mb-2`}>
            {msg.sender === 'bot' && !loading && (
              <img
                src={NUTI_AVATAR}
                alt="Nuti bot"
                className="w-9 h-9 rounded-full border-2 border-emerald-300 shadow mr-2 bg-white object-cover"
                style={{ minWidth: 36, minHeight: 36 }}
              />
            )}
            {msg.sender === 'bot' && loading && i === messages.length - 1 && (
              <div className="w-12 h-9 flex items-center justify-center mr-2">
                <div className="flex gap-1 animate-spin-slow">
                  <img src={nuti2Img} alt="Nuti2" className="w-4 h-4 rounded-full border border-emerald-300 bg-white" />
                  <img src={nuti2Img} alt="Nuti2" className="w-4 h-4 rounded-full border border-emerald-300 bg-white" />
                  <img src={nuti2Img} alt="Nuti2" className="w-4 h-4 rounded-full border border-emerald-300 bg-white" />
                </div>
              </div>
            )}
            <div className={`px-4 py-2 rounded-2xl max-w-[80%] text-base whitespace-pre-line ${
              msg.sender === 'user'
                ? 'bg-emerald-100 text-emerald-900 rounded-br-md'
                : 'bg-emerald-600 text-white rounded-bl-md'
            }`}>
              {msg.text}
            </div>
            {msg.sender === 'user' && <div className="w-9 h-9 ml-2" />}
          </div>
        ))}
        <div ref={chatEndRef} />
      </div>
      <form onSubmit={handleSend} className="flex gap-2 mt-auto">
        <input
          type="text"
          className="flex-1 border border-emerald-300 rounded-full px-4 py-2 focus:outline-none focus:ring-2 focus:ring-emerald-400 bg-white"
          placeholder="Escribe tu pregunta..."
          value={input}
          onChange={e => setInput(e.target.value)}
          disabled={loading}
        />
        <button
          type="submit"
          className="bg-emerald-600 hover:bg-emerald-700 text-white font-bold px-6 py-2 rounded-full shadow transition-all disabled:opacity-50"
          disabled={loading || !input.trim()}
        >
          {loading ? '...' : 'Enviar'}
        </button>
      </form>
      <div className="text-xs text-gray-400 mt-2 text-center">Powered by OpenAI</div>
    </div>
  );
}

/*
Añade esto a tu CSS global o index.css para la animación:
@keyframes spin-slow {
  100% { transform: rotate(360deg); }
}
.animate-spin-slow {
  animation: spin-slow 1.2s linear infinite;
}
*/ 