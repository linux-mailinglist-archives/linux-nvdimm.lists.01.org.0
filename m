Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5B126A577
	for <lists+linux-nvdimm@lfdr.de>; Tue, 15 Sep 2020 14:46:00 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3D7E814C53538;
	Tue, 15 Sep 2020 05:45:59 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.72.192.78; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=<UNKNOWN> 
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7D69614255262
	for <linux-nvdimm@lists.01.org>; Tue, 15 Sep 2020 05:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1600173938;
	bh=956dalJBfbbVIVLPdFKbTJVdPMX5WXoWxlncoe6gU1Q=;
	h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
	b=TF5O1MmFN15vhkQ2FXY4qDjJ9/hg9n+ElPmTmDJJ9AAVdQuz3bQTuD3Njl3rFIqo/
	 TCggOCetJ9vsvU4eBI2juELILoQcMt9v4mAtiUgxNfYr+Kpd0p8+E/qBA27IIhre3a
	 tFzMYiAJNxYoNkIPwopJqHTJ0IwM2OvhCo04Ch+A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.133.87]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5lnF-1kYH6X20XD-0179CF; Tue, 15
 Sep 2020 14:45:38 +0200
To: Jing Xiangfeng <jingxiangfeng@huawei.com>, linux-nvdimm@lists.01.org
Subject: Re: [PATCH] libnvdimm: Fix dereference of pointer ndns before it is
 null checked
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 mQINBFg2+xABEADBJW2hoUoFXVFWTeKbqqif8VjszdMkriilx90WB5c0ddWQX14h6w5bT/A8
 +v43YoGpDNyhgA0w9CEhuwfZrE91GocMtjLO67TAc2i2nxMc/FJRDI0OemO4VJ9RwID6ltwt
 mpVJgXGKkNJ1ey+QOXouzlErVvE2fRh+KXXN1Q7fSmTJlAW9XJYHS3BDHb0uRpymRSX3O+E2
 lA87C7R8qAigPDZi6Z7UmwIA83ZMKXQ5stA0lhPyYgQcM7fh7V4ZYhnR0I5/qkUoxKpqaYLp
 YHBczVP+Zx/zHOM0KQphOMbU7X3c1pmMruoe6ti9uZzqZSLsF+NKXFEPBS665tQr66HJvZvY
 GMDlntZFAZ6xQvCC1r3MGoxEC1tuEa24vPCC9RZ9wk2sY5Csbva0WwYv3WKRZZBv8eIhGMxs
 rcpeGShRFyZ/0BYO53wZAPV1pEhGLLxd8eLN/nEWjJE0ejakPC1H/mt5F+yQBJAzz9JzbToU
 5jKLu0SugNI18MspJut8AiA1M44CIWrNHXvWsQ+nnBKHDHHYZu7MoXlOmB32ndsfPthR3GSv
 jN7YD4Ad724H8fhRijmC1+RpuSce7w2JLj5cYj4MlccmNb8YUxsE8brY2WkXQYS8Ivse39MX
 BE66MQN0r5DQ6oqgoJ4gHIVBUv/ZwgcmUNS5gQkNCFA0dWXznQARAQABtCZNYXJrdXMgRWxm
 cmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPokCVAQTAQgAPhYhBHDP0hzibeXjwQ/ITuU9
 Figxg9azBQJYNvsQAhsjBQkJZgGABQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEOU9Figx
 g9azcyMP/iVihZkZ4VyH3/wlV3nRiXvSreqg+pGPI3c8J6DjP9zvz7QHN35zWM++1yNek7Ar
 OVXwuKBo18ASlYzZPTFJZwQQdkZSV+atwIzG3US50ZZ4p7VyUuDuQQVVqFlaf6qZOkwHSnk+
 CeGxlDz1POSHY17VbJG2CzPuqMfgBtqIU1dODFLpFq4oIAwEOG6fxRa59qbsTLXxyw+PzRaR
 LIjVOit28raM83Efk07JKow8URb4u1n7k9RGAcnsM5/WMLRbDYjWTx0lJ2WO9zYwPgRykhn2
 sOyJVXk9xVESGTwEPbTtfHM+4x0n0gC6GzfTMvwvZ9G6xoM0S4/+lgbaaa9t5tT/PrsvJiob
 kfqDrPbmSwr2G5mHnSM9M7B+w8odjmQFOwAjfcxoVIHxC4Cl/GAAKsX3KNKTspCHR0Yag78w
 i8duH/eEd4tB8twcqCi3aCgWoIrhjNS0myusmuA89kAWFFW5z26qNCOefovCx8drdMXQfMYv
 g5lRk821ZCNBosfRUvcMXoY6lTwHLIDrEfkJQtjxfdTlWQdwr0mM5ye7vd83AManSQwutgpI
 q+wE8CNY2VN9xAlE7OhcmWXlnAw3MJLW863SXdGlnkA3N+U4BoKQSIToGuXARQ14IMNvfeKX
 NphLPpUUnUNdfxAHu/S3tPTc/E/oePbHo794dnEm57LuuQINBFg2+xABEADZg/T+4o5qj4cw
 nd0G5pFy7ACxk28mSrLuva9tyzqPgRZ2bdPiwNXJUvBg1es2u81urekeUvGvnERB/TKekp25
 4wU3I2lEhIXj5NVdLc6eU5czZQs4YEZbu1U5iqhhZmKhlLrhLlZv2whLOXRlLwi4jAzXIZAu
 76mT813jbczl2dwxFxcT8XRzk9+dwzNTdOg75683uinMgskiiul+dzd6sumdOhRZR7YBT+xC
 wzfykOgBKnzfFscMwKR0iuHNB+VdEnZw80XGZi4N1ku81DHxmo2HG3icg7CwO1ih2jx8ik0r
 riIyMhJrTXgR1hF6kQnX7p2mXe6K0s8tQFK0ZZmYpZuGYYsV05OvU8yqrRVL/GYvy4Xgplm3
 DuMuC7/A9/BfmxZVEPAS1gW6QQ8vSO4zf60zREKoSNYeiv+tURM2KOEj8tCMZN3k3sNASfoG
 fMvTvOjT0yzMbJsI1jwLwy5uA2JVdSLoWzBD8awZ2X/eCU9YDZeGuWmxzIHvkuMj8FfX8cK/
 2m437UA877eqmcgiEy/3B7XeHUipOL83gjfq4ETzVmxVswkVvZvR6j2blQVr+MhCZPq83Ota
 xNB7QptPxJuNRZ49gtT6uQkyGI+2daXqkj/Mot5tKxNKtM1Vbr/3b+AEMA7qLz7QjhgGJcie
 qp4b0gELjY1Oe9dBAXMiDwARAQABiQI8BBgBCAAmFiEEcM/SHOJt5ePBD8hO5T0WKDGD1rMF
 Alg2+xACGwwFCQlmAYAACgkQ5T0WKDGD1rOYSw/+P6fYSZjTJDAl9XNfXRjRRyJSfaw6N1pA
 Ahuu0MIa3djFRuFCrAHUaaFZf5V2iW5xhGnrhDwE1Ksf7tlstSne/G0a+Ef7vhUyeTn6U/0m
 +/BrsCsBUXhqeNuraGUtaleatQijXfuemUwgB+mE3B0SobE601XLo6MYIhPh8MG32MKO5kOY
 hB5jzyor7WoN3ETVNQoGgMzPVWIRElwpcXr+yGoTLAOpG7nkAUBBj9n9TPpSdt/npfok9ZfL
 /Q+ranrxb2Cy4tvOPxeVfR58XveX85ICrW9VHPVq9sJf/a24bMm6+qEg1V/G7u/AM3fM8U2m
 tdrTqOrfxklZ7beppGKzC1/WLrcr072vrdiN0icyOHQlfWmaPv0pUnW3AwtiMYngT96BevfA
 qlwaymjPTvH+cTXScnbydfOQW8220JQwykUe+sHRZfAF5TS2YCkQvsyf7vIpSqo/ttDk4+xc
 Z/wsLiWTgKlih2QYULvW61XU+mWsK8+ZlYUrRMpkauN4CJ5yTpvp+Orcz5KixHQmc5tbkLWf
 x0n1QFc1xxJhbzN+r9djSGGN/5IBDfUqSANC8cWzHpWaHmSuU3JSAMB/N+yQjIad2ztTckZY
 pwT6oxng29LzZspTYUEzMz3wK2jQHw+U66qBFk8whA7B2uAU1QdGyPgahLYSOa4XAEGb6wbI FEE=
Message-ID: <79904eb4-8314-ea99-a3c9-a34d6272b3e9@web.de>
Date: Tue, 15 Sep 2020 14:45:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:eWk+fDSsJ/ScRVvJrnaDVWxiQk5f2Gs9osx7W0MlZl+utJ1QU+g
 vUl28EbTKK5qx+NxIYcFrUS2qrC2FMFxUyACOmCBGQDHkf6Iwf1677bBGE1YdMi22bzwut0
 TbX9ZsAsysdrKOHCCOzTrnUzbdJLiA0dnS48ezNUmX/Ei1JRBfaPgNf71E9chB/dNcvGsuW
 1SD5B1ZVA2cdWOBDXAOfg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9dTFY1y49as=:4aYSV8gH3H81B4ynTcVUHf
 QGLs9xrz8/Fa1L4WvUGKSPcJf+P5oeYFG2gW4qJxUbjBNEK8B8zWjGpgp2vrgQ96DXbjQ7STS
 S1qjNnOy6B0JnwX46OckKN6EE8S/LVmqmPGOjnc0CEUou0Xf6yg5lGGaTTbb0svBFfWtq+Kyv
 mXLxgDHfgL2+5NO6JavMck3UvvbE8sr8JYsiCBGU60MUF85C6QHdocDfkwk6l1QyCnUyz6I0X
 W1xYJgEgwYtC7VEXYHaLZgFe3+PmFZXMetmsyvKsgKSL20kEiXymFUcpP67VZ3k+8ySy6hNAY
 SzxIGS5j3HkJ2sOl5a+yXT0voipxNmhrDbVwpSyF1kUMNCBfE8rL7XgcrjbGLj+FQLWc5iilW
 jBUT8PB+w6+I9PQlPV3+s+k7u5R10LxYeAmoCVsXO5/kE69rEbUe9Own8o8OCOkyYVQ8GQ0QV
 G2Fp1E65FnkbKA4xsRE5lFCGQvL3fityJ0F9E2dNAznJllk2KwticOPxvh8PIFK/mQmITmg4S
 1T7a5gfvEMGoisfJx+olmXLe/N+D8hKS9JlkJnKnRBApyMKIBoB5aZTInsutvOQ+rnhIKTuKG
 TEseYtYMGjYNDMG+weWAyesM2sLKNprbEIINqM7ILthI+wk7egKYb1rqOTxDE6nJXTmyzSuic
 CeeNgp2cGQGe6m1v/MF29ooWRdtXD99aF/w60XJvNOsTj3vKCok2tfpJmP8tpg68gqtn1+4In
 KtA2d+pZKwKRNKo52YfIRneNuvKuMqmFdYRphuhYTQw1fLp6KX/wTz9SaqO8J6py1GmcvmeC1
 RsOFumJxRz1SQkyhl0m7AJoX6z9XhJZyE3vCpRd+72sXKNW43xp1ihQYqfOXUYIjgwELHYfS5
 +CVGu9h8JzMXhCrWr3G4wVEC9mGmF/eaW0JLu5SlthHT3eFNBCXgcUF8/GF7ZSvSCnQzhF9ed
 bff9JEzS9knRhIjB65R6WHQKnOR04a4NKYpIhvKZMOFvWZq/N5mp+DTZ/7YytU+ijcs+QEQIr
 YMc5Q48mF5XoiNjOk/O9Ra9Z4iPsoegy2LSZYCxxUxHgoHF0rgMm8GdiqpdXy12z+0KoDwb28
 a1cKyEL1ZTYOqyyZjtg1AzMJY7FZIPERPfSGFFzTGt49OOucdqszHvnSQeJJoaCrzS5CIuw4h
 BE/KUE/s8uNhYwD3g89/o8u9eYeqM0oFXprpNCq42ANrPWDNE55acimaPA7jBe9xHhTNNrr0v
 WcGmSPyqqTxDtRAnx2xqxjvpyzeI0nuSLmRM97Q==
Message-ID-Hash: NH27IC3CUCSLQIBX5F3O3EUD4N6PVYWW
X-Message-ID-Hash: NH27IC3CUCSLQIBX5F3O3EUD4N6PVYWW
X-MailFrom: Markus.Elfring@web.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Zhen Lei <thunder.leizhen@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NH27IC3CUCSLQIBX5F3O3EUD4N6PVYWW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiDigKYgRml4IHRoaXMgYnkNCg0KSSBzdWdnZXN0IHRvIHJlcGxhY2UgdGhpcyBpbmZvcm1hdGlv
biBieSB0aGUgdGFnIOKAnEZpeGVz4oCdLg0KDQoNCj4gZGVyZWZlcmVuY2luZyBuZG5zIGFmdGVy
IG5kbnMgaGFzIGJlZW4gbnVsbCBwb2ludGVyIHNhbml0eSBjaGVja2VkLg0KDQpXb3VsZCBhbiBv
dGhlciBpbXBlcmF0aXZlIHdvcmRpbmcgYmVjb21lIGhlbHBmdWwgZm9yIHRoZSBjaGFuZ2UgZGVz
Y3JpcHRpb24/DQoNClJlZ2FyZHMsDQpNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1u
dmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgt
bnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
