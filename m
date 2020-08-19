Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A73F1249DD6
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Aug 2020 14:29:01 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C95EC13505CC9;
	Wed, 19 Aug 2020 05:28:59 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.72.192.78; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=<UNKNOWN> 
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9382713505CC6
	for <linux-nvdimm@lists.01.org>; Wed, 19 Aug 2020 05:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1597840117;
	bh=LunTLKJJ1JcbEznPbkQKD+DItyAuEDXtX1Anemwap1s=;
	h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
	b=gMxv6otEktFO0QixfeJpITEkdkh2VaWRkigk9IdU8yJu14MV2HSG9KaOgdJhFbaR0
	 /BAYlheHMfmAJE8SUBt3RovOHWPX02zp2cQlwXa1TMFg5TemwkAaOesE0Q9stxdmcJ
	 OeVnZfpBEBXSvrBSDf12a57GNqYSXsOnPqZEDzsc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.132.88]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MAdol-1jxfp82ECR-00BuH0; Wed, 19
 Aug 2020 14:28:37 +0200
Subject: Re: [PATCH v2 1/4] libnvdimm: Fix memory leaks in of_pmem.c
To: Zhen Lei <thunder.leizhen@huawei.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
References: <20200819020503.3079-1-thunder.leizhen@huawei.com>
 <20200819020503.3079-2-thunder.leizhen@huawei.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <5cc26ce3-963e-3ab6-6f97-706cea00c5f3@web.de>
Date: Wed, 19 Aug 2020 14:28:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200819020503.3079-2-thunder.leizhen@huawei.com>
Content-Language: en-GB
X-Provags-ID: V03:K1:eZLDlBeanQCQstde04APr19Hec66rOtfFRzGiTObsXarYp8KqgP
 oVy5m4kj+L46TKw7ksKpidRylEVOom/b+/O7nLFovK/aaDRZVRSDqjPN8NQ6h8j7niGhi6S
 t3nkbhAiHuKlD2gLZVeokvTE19xpJNYCubQoYkeDczwXb3NSZrVhvlgXMNQma64UIkr0LGt
 Ak4mx1OK7biH9/GoczKxQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OzDgz783024=:dHWsrBy6zQhTLOlRST4OE4
 vIJzIc66uO1iY1q4tm2Rf2z75H/eC6r2hkEfn7B2nqpAeJzy/a/VGIrZCzUneLxrOcVqfUc2c
 msZveRgFxepsgiRBVvobUPlT8fYRlcFofW0p39wnpjwRiFgG2kuPE+qjsoH9/9fyJ8e68PouC
 rP+G+BB37Ksltn/I4UQ+eP10ptSgitGDo2AdEZJupsUTsVm8KVBK41TGZ9Soqbjq+Tii/9rtb
 /x07SgAp4STj8V2X9Sw3KKIEo0rg83u6weR7EmJ4niWwXOh1+SzYZ/E1k6xK8aP3uZF/fEPr/
 iuinVDKI4uqqhZ9eBIAUSwjWore2aEyllR1Ln0LCAjA3PqpqDU3sOO7owNbvrN0yifNn9O0CY
 QqMf4PTC9LJ5I1jmoaYCrGW/bmkH9u34dO5jWTGUeLvQ0TQs8F4kbDM4msSo6cTGy399tqfZ0
 WYL/ZTjovU59PeVpQ9XbyJrtcVIj72syGstQsakEthVVm5SkBKmgAZ8dH5xoh0nXxnfQaODnu
 bhVhQCATl/gvKD8bBFOqyyeW9MwMhv58QkspKe7z6+d5ouPcC+P7vb3wNcKvgbP3H0R9MwevW
 1PVeEckmvcTtEP6XHKaM0Jycz6lz84eNMmfn3xU8CPYC2vFZfEChrlMbC5geBQ5E1pLNjdMXA
 +I3ZFDNmL+r4Ms+WzZ3jyRnT/XkkWfzKst4mi09RioQ3yXxMC7KJyMi9PygF4E/0qVr7p0dST
 9sY6FQPQMzhkde0Q/a/GB2+4q9t1/ifebh9rxK47O2r1qQiMOWLGpgEp/OJ/+oardX6KXk5oR
 MIC7zTggNIHBj3kHf/jnTn+Terc8wTyaH36z8j9LLB5jGvPxUX7nYDc6/1ug/LEW9RJ3cglVv
 YjnlZegKImu4AmG+vmlof2w3UKwQ5pMjBT8nm/KEJMBs0ECQcwWyM+q9Y85obJkW7qd3itLur
 PXed71zGU9ljp6fn7eM9YpYQ6QHDUAm4RqLc2fiqa6ZY0AhUqd3VPM60hzJ27DVxUCl2LCOv/
 wgIVrz05NtUuBcCVNTEkf8EPC49kKXTDIox+y3YZYEuoRgfmbjFOdbTogdINDe947oBs2zrOj
 Abl2VLBaa4T8tONx4uDB1OrW7smpIO9sm2TjPf9ARErFtoRE5YcUXTp6W2x0uB6qWAXwTn5JH
 9XzSnpRAyj4sqBXn0cWS7m8eDxrctdQ7TFhFX8JPWIfi/ig/8AtczNMUIWnAiLtGhRDlOE/J9
 d0oIfP3sR2G4JhOtNYmTl1+/8bPVhLVwgLUX97g==
Message-ID-Hash: JTRG7LESRO4FKWBO7QBKYN57L6ODXQMW
X-Message-ID-Hash: JTRG7LESRO4FKWBO7QBKYN57L6ODXQMW
X-MailFrom: Markus.Elfring@web.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JTRG7LESRO4FKWBO7QBKYN57L6ODXQMW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> The memory priv->bus_desc.provider_name allocated by kstrdup() is not
> freed correctly.

How do you think about to choose an imperative wording for
a corresponding change description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=18445bf405cb331117bc98427b1ba6f12418ad17#n151

Regards,
Markus
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
