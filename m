Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1660248E5D
	for <lists+linux-nvdimm@lfdr.de>; Tue, 18 Aug 2020 21:00:52 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 67B26134B448D;
	Tue, 18 Aug 2020 12:00:49 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.3; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=<UNKNOWN> 
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 46936134B448B
	for <linux-nvdimm@lists.01.org>; Tue, 18 Aug 2020 12:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1597777229;
	bh=8tPaOBz1oL4sjCx68kvoi7WNYSNGP6BDuiN9f4LOYBg=;
	h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
	b=j+i9MqWWy4RFHFY1yieRx9uLkDpLIypMDti0QovWqPe7d1KDjxybDqA5643tV5bfc
	 C3s1GCWq4BFw8cXYcOsA/DG5RxRcx7UZZttdJs19J7m2iJtP+NN7Lnso1qiHmozViS
	 20Xv9bbErl3J4Ym9REGSP1zi4nEKm43D1NvfKPgw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.140.173]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MYefK-1kD73G3aGQ-00VTo5; Tue, 18
 Aug 2020 21:00:28 +0200
To: Zhen Lei <thunder.leizhen@huawei.com>, linux-nvdimm@lists.01.org
Subject: Re: [PATCH 1/3] libnvdimm: Fix memory leaks in of_pmem.c
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <5ca9f6e3-38d7-fc65-5010-22c992ecf851@web.de>
Date: Tue, 18 Aug 2020 21:00:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:WX9c3W2T61A87vrEFN/JkcTcXlZto0ipTF5T4ovUclOzr9jpoJQ
 2dMXh2o3tQEi9pBGwAV3FNsuhp3DPBgHp9ZVEGIt7vWJYhF0pOwfTJIz3bU7ldFj0EI+f52
 DOB30J+zhXmqyG8xLuk6b9NbnnyL7lAsiA2V4TJtTwGAQcgOuv1lNDEEcGDxR9fAB9UN0oo
 oQ+4449+2SpEPsnanzAaA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OWSed1+GdGE=:yxYf5AfSyAipzvGZMMAH8A
 hjI3O+sk9jrkkOa6GNbrAFpVBpSfDk2KquRg0Q6dSTGT7qelUlwGshwu0Z0rDc4OErmgArWQe
 cE7LRe7OVC3R98KMONcJpRvlEko3gWcfJ6VA3HVo370E1oBjVcRGvn6ljrj1CKsvuOyt37rdf
 Su3oQog1donbkQOjKd+/HgoOm7f1PwFClV8nFOy5Wijw6XS/lTh10Q7d6pRCEqRQFu92yWl3d
 HMGfJre9ycoozXeLt6O+P+pwMlAiaDP6AzBVhXoRWbRmRyyUR0Kh81SaNSLWJwVguRUaf9WGh
 nSHIBOyE/0AJtAMMWVfzSQRql6hAqlmcrftvXDN8n7HnRYuI+tkAbObg81MPg8F6krshwWpkf
 ce0S6dYwbfwB8NiCkxPPOxWvUyzat21QV9lOdTk9hIn3encGh62GbtM183iTnNuww8O2LkDd5
 b6VkmZdBhFmq3aXWtJ2EpmRELqOzDs1aQOjGD/urT8qQXqjuFFzu8ncbQzT5dsY9sBAaTBPtD
 jMcp0tb1lA2Wpzq5vWJhQX5ZZOXv6NkwZ8dBKzpJcldhmMw8D68VPlkAFSQs8wv3VFxY0lz6l
 TDOJdcRhUiM+WdovrkhW4zCYjyev+SxWTu51V+qO3R7er4wQZ9Vta0PcCiQ+10X+PVG+ZXGly
 Q1Ph1YLRirBeBDeJaPjhMHxztcdaoCzyHaq+ovmMMky/91QOC2NkPfz/7sm4ZRxn7ipnb4xvi
 bkWi6yfu5f6sm1TVIT25F6u6SXgJJeXhz3TD35gyteAvmq3ulQ1+/BJqq7hNvF2C62Pjn42nE
 lgibbVj9yR84TfUysVVKMq3PmQB/P0gWNVobpKn4Ek4sOisdFOkAk0XJqnXwfE7VFzsjgd9qc
 LYa7xn5Q+6AiM9GbGI/H2FKuWbTjO5GTQWGlDZxC9h6V2Y6B06Qn53NLwDgkSgYW2xKiB4wrY
 C/LygWNHDO7QXradnDee06jThZs/DF0YDInHTiCERD855a1AbgAmdYd+yL48228AKJq/fgBg3
 YgJGR1RPAqIchsegJzlkvw0Vvwzr+WvrnG7d9Js9aHPeSis3iOYl7XRwP4I73br5oZEWynEHf
 tZP4TA65HwU12eJQ1/934E/HMGFUnnyc7puzvA8kS7R3d2yaUruYku2q6KY5kYVadgKhY4Th4
 /b/UWPLD8IPEYQUX9IvX/wEwDhm+09Yf3XSeZKnPR47jromEHFWMYbebKbCWe8NiyLufaGXVQ
 M2GswWA5ZlgyYDuk1bRV/YkmhN3N2MVl1S6muCQ==
Message-ID-Hash: HCM3DAAIILW7SOVGA2QQKWROCL57TUIC
X-Message-ID-Hash: HCM3DAAIILW7SOVGA2QQKWROCL57TUIC
X-MailFrom: Markus.Elfring@web.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HCM3DAAIILW7SOVGA2QQKWROCL57TUIC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiBUaGUgbWVtb3J5IHByaXYtPmJ1c19kZXNjLnByb3ZpZGVyX25hbWUgYWxsb2NhdGVkIGJ5IGtz
dHJkdXAoKSBzaG91bGQgYmUNCj4gZnJlZWQuDQoNCiogV291bGQgYW4gaW1wZXJhdGl2ZSB3b3Jk
aW5nIGJlIHByZWZlcnJlZCBmb3IgdGhlIGNoYW5nZSBkZXNjcmlwdGlvbj8NCg0KKiBJIHByb3Bv
c2UgdG8gYWRkIHRoZSB0YWcg4oCcRml4ZXPigJ0gdG8gdGhlIGNvbW1pdCBtZXNzYWdlLg0KDQpS
ZWdhcmRzLA0KTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAx
Lm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBs
aXN0cy4wMS5vcmcK
