Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 063B6249DAE
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Aug 2020 14:21:05 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2F44513505CA0;
	Wed, 19 Aug 2020 05:21:03 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.17.11; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=<UNKNOWN> 
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 512D9134FC6EC
	for <linux-nvdimm@lists.01.org>; Wed, 19 Aug 2020 05:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1597839643;
	bh=v23jcDeGLgtsG3K4AD5B8PpZFv5q6Wp5N8tUvFrTPu4=;
	h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
	b=qKckbMWbCkNEcSXCKsxjC3LbmKL8JPy5U6/a/jM/0DdK13Q0BvCDQ+M9N4oDSUIqD
	 eRHQ+sX1xnLk+0mAw/GS4auY1+26ySZuerY3I9wj3nBQWd9CiDfUJepa1XR0sdfro4
	 WnXPNnHZWvb0oKgFPM6moDUSDLT/eBNZ9LCoS3bM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.132.88]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LcgVn-1kY7f33Clj-00k87H; Wed, 19
 Aug 2020 14:20:42 +0200
Subject: Re: [PATCH v2 0/4] bug fix and optimize for drivers/nvdimm
To: Zhen Lei <thunder.leizhen@huawei.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
References: <20200819020503.3079-1-thunder.leizhen@huawei.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <ce85d12b-f0bf-8cdd-0477-8ee87ff5a4c9@web.de>
Date: Wed, 19 Aug 2020 14:20:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200819020503.3079-1-thunder.leizhen@huawei.com>
Content-Language: en-GB
X-Provags-ID: V03:K1:BfN9rJFl67mBIpUeOhw4vdlTDfHfkVpmH0v03UkAhJhcoofYGfC
 1JP/T6ruDmKM8TWKxqz47zGu6wNE82PHyv9M4XIFcPwU63d0zKIWMhWWshJYzrDUuWU6Aty
 dh0U3lt58uJkZ74u5VG5XZmCUHITZQZ2kXdOUiN1WRzfa4HI7cFkeTsbD2XDNXSPpYSzGHZ
 BjtfuT0yX8xTuXR5eXsVg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dyc0cOxfPgA=:vpcmZTA4FhRgUFe5ygKoqO
 2YGxZsI7sU6+pFq6xpS6Q3nfL5lzH+0IiblKnk01GxY+yNIADVFfJ3KOVFYBRI4xnWR9vZXT0
 VweIF0fXXkSIPpusXTJ3qA+G6pxBctcmxqxiMDsOsPl+ndLTyWXTQr5xsKjBO6XC30vLINfO3
 kb/brieaM7Um5Fjz2AO919Qjcgp7lrs+e2y8b4vYLUQqhRMVT3VehJ77bOqIKZg84n9zZvTAO
 I87GdRApEj0K42P0InxOMQO26CXDqMdN2wrDLQ7Ug5IRfWo9RZ7lfzFfO96x2+xdgsnIcC8Nw
 WvjrUmO8Lm5ATPkL3eci0Ryc9jskIggia0s9TJkhcpUqZyjj9nH0GX06ED9sbYIoxWmIQxc+1
 CqWXiXEESPOs8+vhvYOOJLIDiaWVB/2PBFplUv+jxnYdedQYmant4RicNaDDodUImvBgDN12H
 9pfoqpmyB7xT97REywFSw4OD63AQ1ItrvLzHyJ4azm3E8yXbDPSYUO7HZgz78hYGQ2koENRnT
 m7Fj78nV00jk6dlfisaT8OEu4wWCoY4etphcqm1eBS1CDFkjS7rfk6mygjUyoWS3wjl/g+IFL
 k6ea3fG0afumw4aFtI6VMPghhdFYBStZtHMQYrpwr1NAcnqulg1LhOHmlAPuEVkqEQd30X4gZ
 OPhVADpHNq4ix2OUs3EWCAUW7HbIY5ejGNHAhiPHQxy/bn2YckHul2TDwxq+AGIOXXo67CEwG
 NMDu9UgAs92bAhp7yJe7y7HWbLW7rUGbHLWSeAZgJf+l/qZU7l7SlYv5OpqGlcpCwPODrlviK
 6YEFgajXeNpsPec7CkNR88gg8TAOLtGLjdWM+5oESczLkrhlNIk/qgfL6HK2vPKS8Fd3aQyXm
 TpakdNF/RYcyy9umnioGDPZw1idL2PSn6kJDaeodcQmH7M5cGfXXtUjIlLkDPmj3sNLHzQMl3
 j//yc+59cR1F9Fmp90VJFDV6NQXEOLdp9PzV5T15J+cs/gD/Nre228LQvVZ3Ne/jb2BCm8Unf
 K3r5G82BowKLMXwWenbNETOayp9B3CTANK4xGS3g4oDxCIn1VQz8tC5gv58+tlle0iQ9Y4zYQ
 gJIjEPxpuMQocVjw9Rj9E4uoY1cAcjPUFkWdKkP4WPt6jNkiF54kfX4JHSywfZAXvUKelmNsj
 XXtTNmGCpEideSqHr28/VOFAl69MK7Ja2DFZ0MFXPAlA3SubP+2mE0Iv/mZm82spYTaBeT5W/
 iLvEUue/PQ3W95/pFw+l3dx0vmTbf6mHGgexuYg==
Message-ID-Hash: RUUHWPYYAOYWKQCYJI25R27MHQB2VIK2
X-Message-ID-Hash: RUUHWPYYAOYWKQCYJI25R27MHQB2VIK2
X-MailFrom: Markus.Elfring@web.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RUUHWPYYAOYWKQCYJI25R27MHQB2VIK2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiB2MSAtLT4gdjI6DQo+IDEuIEFkZCBGaXhlcyBmb3IgUGF0Y2ggMS0yDQo+IDIuIFNsaWdodGx5
IGNoYW5nZSB0aGUgc3ViamVjdCBhbmQgZGVzY3JpcHRpb24gb2YgUGF0Y2ggMQ0K4oCmDQo+ICAg
bGlibnZkaW1tOiBmaXggbWVtbW9yeSBsZWFrcyBpbiBvZl9wbWVtLmMNCuKApg0KDQpJIHN1Z2dl
c3QgdG8gYXZvaWQgYSB0eXBvIGluIHN1Y2ggYSBwYXRjaCBzdWJqZWN0Lg0KDQpSZWdhcmRzLA0K
TWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1
bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5v
cmcK
