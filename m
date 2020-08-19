Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A664249E44
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Aug 2020 14:41:06 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ACB181350A3BB;
	Wed, 19 Aug 2020 05:41:04 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.17.11; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=<UNKNOWN> 
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E54C413505CC6
	for <linux-nvdimm@lists.01.org>; Wed, 19 Aug 2020 05:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1597840844;
	bh=d1QvhiU0EQDguAu6Bm+SahJUccuqRek3ApeKnL30RM0=;
	h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
	b=Mw23gUw481OZl3/UzZzuGeNCNnNZS/k5+JUMUDPGI/OnxRgwfVAyC6vFl14NZmoFQ
	 4LCn5w411kjf809hKRRo3dgGEeMIfKz9FmLjctY5KBD3gPQ1SW9RKWwgumGwx36EX/
	 EoBbunumImJE8NMT+gaVhiVnVqsA6/FmTCAg3vcY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.132.88]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MXYeQ-1kCJGn3hag-00WWo4; Wed, 19
 Aug 2020 14:40:44 +0200
Subject: Re: [PATCH v2 3/4] libnvdimm/bus: simplify walk_to_nvdimm_bus()
To: Zhen Lei <thunder.leizhen@huawei.com>, linux-nvdimm@lists.01.org
References: <20200819020503.3079-1-thunder.leizhen@huawei.com>
 <20200819020503.3079-4-thunder.leizhen@huawei.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <ff1333cb-9917-6a2c-4454-325d161d8650@web.de>
Date: Wed, 19 Aug 2020 14:40:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200819020503.3079-4-thunder.leizhen@huawei.com>
Content-Language: en-GB
X-Provags-ID: V03:K1:5SYZFwycDRQ6Nd5TrVjROq5e0N9Rn2cXoZ6pa8JFlNibw6y0Me1
 hKEq0eGQzmVw1kGccEs1swTJ8zupzP8pb6jVkOeCD+IvstGxAaOdatNokS8YFa0O27ynq+Z
 wJ1VnK9A3f0OwL1+riUGjv2SqNCTTthvdZuiBrnX2c2JyD24FNSvyuf6caoeEhK03TvcUcn
 nKLgOTWVmhGX/U1dOo/Tw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MpkknXMA8lI=:ZfGcJ85c93oFY0oVDd+dOn
 Vp1uqgdJBM27ecWBxLj4Wih2tjx2S39ER9VSdCizB6lK+2vRmMxxy5/0xnZZ1d8fSJ/Dp6kpp
 UkTc7awX2+KbpIx0CKfvHtjGZxXXOGan6q8AlBOBHc84DSan5bpoaI3MwQ0PeupjsqbcuMpHv
 n2nUcF/BWUn/VfrXvxO1x+3c+Ef4wbISuf7sS9NuU4Skdz9gqm0oBDgssXcTuQjxCsAV4T7ef
 jud1bNASwpk7SyPduhcB43nwTzUvNpQnww+p0wbNeuW2er9kXhlINkQhsd81EEHst1lVeti+K
 kd7oL0xsOun+LfmON9WLFoOcRbi1mqS+O/o0+O3NnsRE2wb+oocmjDhFGTbt99pusFcnAbrZp
 Si7RpZriSta/oIKJU1dMzJNapnZ84WeLZW0NncZura8xRBOkwuHq+M8JIm1rVTqK8Fea3EqfT
 Ny22KcQezK10HFurkn/TbSPb6JKe6FaxrA0j6nERLmOWxyrxGxOThXlBEniCZ8hvbW1xZoPU+
 SJcyNVYTRGQUXM79j+Bi0HctkV7uB7O3q3dgW3AvB6oJt86h1fWdvzdwSsRqotNxl9HA0LN2U
 RV3T7b7zeJwIuZ47k/ITVyL6RRxljlGS7STR9VWs11WbPsA4E3LKRLqjDhyirO3zHqDJOrV5t
 XgaFZAVkLSVcuvaR5ZM11fTxtF3jfFN7F5Pmv6gu4hN0RGYjuA2x76nxcHormd8I9+7qgqU0y
 be1hc8p+tvPxL2qhq5DNj0+qgJzx3uGUjwmUXpM7wrtRaNEnEGaPnG0zS1cMDdvAmkZBtKsEF
 U0jSuhaMmEf4dbLTNo9IqoMxa1xjPu58MADL/AOteA55sxJ+FE2P+62qEREyfNjpsuGb9eML4
 TGdzf9NHZlAbVfRI39WjALWZoPGaNl1ED1j86piODSFt18Tjqw2r5eSfe/HkD2X+NGrIW+Ay7
 4uJnmxnSh0kZNC+sWOK6l54VOVDd9xg4ThbkxMd3GPkn7Gn9XSlUBwuR5qIo0j6nhxG1dIj4t
 HzmkXNAkcv9Tf04mXovsjAUs/47AOzNSuyGptRVr9lDT+bSfUhKnIUXVNsBKIyx+uXpSYEtBy
 4kn+Anh1fwc18bZrFcQDqKFbsuuezbFzwL0t13GQBOWxRA30CCpZp3TmfSI3Vcb023KXAB2qW
 Ir8cVALO91v9yzkh8ZruwBeFodwgeaH+cKg49VDpxNDEzFf0uZkWb7rzLsWImrIff8PNO0MkL
 g7+ZXfWumMZjU7ur6n/ggXF3eXhqgdd3HHCvXaA==
Message-ID-Hash: 6UKX65UVJPTNI2TAO43ZOVKVEK4WSXJU
X-Message-ID-Hash: 6UKX65UVJPTNI2TAO43ZOVKVEK4WSXJU
X-MailFrom: Markus.Elfring@web.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6UKX65UVJPTNI2TAO43ZOVKVEK4WSXJU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiDigKYgd2hlbiBpc19udmRpbW1fYnVzKGRldikgc3VjY2Vzc2VkLg0KDQpJIGltYWdpbmUgdGhh
dCB0aGF0IGFuIG90aGVyIHdvcmRpbmcgd2lsbCBiZSBtb3JlIGFwcHJvcHJpYXRlIGhlcmUuDQoN
ClJlZ2FyZHMsDQpNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMu
MDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZl
QGxpc3RzLjAxLm9yZwo=
