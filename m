Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE095D89B
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Jul 2019 02:22:57 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 90D45212AC486;
	Tue,  2 Jul 2019 17:22:55 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com;
 envelope-from=openosd@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 9DB65212AC481
 for <linux-nvdimm@lists.01.org>; Tue,  2 Jul 2019 17:22:53 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id d4so262421edr.13
 for <linux-nvdimm@lists.01.org>; Tue, 02 Jul 2019 17:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=O3TFYB/c8JGnIRSgqNPJw6u3GSkSqR28UU4ekieR1ww=;
 b=c0Orqe6NQBE+sHLXT5J5nmlLtMemzO5waTwx4hEj7Bl04/hl6C0P+6hPRYDEAfph90
 kg1ZVytJWoslu+wvzvpUmTJPGiWopB+CqjCPc1Ge/93q2IP0ruxhLtlIhl9ed5+hAqt5
 /04yd0PyFdt0vekPpPo4dFYgQoX6r20BGdXRZhU33xxOAymQ9VLEdjBkSUPX4Ohh4xaK
 oeKBpm1hXGBKA61bwDXLWcFXYxJKHcfDwnjVubiVNIz/V5hs0Bw4n8t7dH6rTZ7TISUi
 8mAGclvqyCqY9XkLjYY0ydocBF0Zn5lUOoodMkb+gzJ84nYE5DlVPwzL6wE4hw5zTVn7
 NnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=O3TFYB/c8JGnIRSgqNPJw6u3GSkSqR28UU4ekieR1ww=;
 b=ENNGetPgTZPNtYyny2g1i37duqgeo1Q6l8lNB4gowB5WxPsqgEOp8R6bUw/6vS777H
 PKOmGnGfqcizy78R9M6BmlfKbu0L/ZHS61vKzfsk+XUyKqwAaBkrPdD7ddujhUM+Z6Uh
 t8x4MD4N0b1tSlTki7wFs3mtOsFVeJMi7X1MECJJL1Obl4DrInDNg/9PFPysq+x19Z2Q
 hQoriVMoLND/3NM+1b8zaBkq7H2shoUMY4wMYcbf3HaBh9ww/rsM0lkUx5moDIFw2CUN
 JGDxxTK5laTDdU+k222/C5kSiE39i79XKKAba8MduK2Lm+hsQfc29DF5fStIEdkxiRXX
 JRpg==
X-Gm-Message-State: APjAAAVtKatA4kgjvUFuszRJNfDRhOGAG6qdLSqEyYXej6Ad0M8y5z9q
 Y+FaIiETUC6keQMRQ98nShM=
X-Google-Smtp-Source: APXvYqw0ZksS0YC+pGL/ouOk9KhOw5LGAqS0CHttjy+Br4pM+v+dICQr6KzW3wmEDGg0H++t5zQLow==
X-Received: by 2002:aa7:c692:: with SMTP id n18mr38211777edq.220.1562113372104; 
 Tue, 02 Jul 2019 17:22:52 -0700 (PDT)
Received: from [10.68.217.182] ([217.70.211.18])
 by smtp.gmail.com with ESMTPSA id b19sm113853eje.80.2019.07.02.17.22.50
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Jul 2019 17:22:51 -0700 (PDT)
Subject: Re: [PATCH] filesystem-dax: Disable PMD support
To: Dan Williams <dan.j.williams@intel.com>,
 Matthew Wilcox <willy@infradead.org>
References: <CAPcyv4jjqooboxivY=AsfEPhCvxdwU66GpwE9vM+cqrZWvtX3g@mail.gmail.com>
 <CAPcyv4h6HgNE38RF5TxO3C268ZvrxgcPNrPWOt94MnO5gP_pjw@mail.gmail.com>
 <CAPcyv4gwd1_VHk_MfHeNSxyH+N1=aatj9WkKXqYNPkSXe4bFDg@mail.gmail.com>
 <20190627195948.GB4286@bombadil.infradead.org>
 <CAPcyv4iB3f1hDdCsw=Cy234dP-RXpxGyXDoTwEU8nt5qUDEVQg@mail.gmail.com>
 <20190629160336.GB1180@bombadil.infradead.org>
 <CAPcyv4ge3Ht1k_v=tSoVA6hCzKg1N3imhs_rTL3oTB+5_KC8_Q@mail.gmail.com>
 <CAA9_cmcb-Prn6CnOx-mJfb9CRdf0uG9u4M1Vq1B1rKVemCD-Vw@mail.gmail.com>
 <20190630152324.GA15900@bombadil.infradead.org>
 <CAPcyv4j2NBPBEUU3UW1Q5OyOEuo9R5e90HpkowpeEkMsAKiUyQ@mail.gmail.com>
 <20190702033410.GB1729@bombadil.infradead.org>
 <CAPcyv4iEkN1o5HD6Gb9m5ohdAVQhmtiTDcFE+PMQczYx635Vwg@mail.gmail.com>
From: Boaz Harrosh <openosd@gmail.com>
Message-ID: <fa9b9165-7910-1fbd-fb5b-78023936d2f2@gmail.com>
Date: Wed, 3 Jul 2019 03:22:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4iEkN1o5HD6Gb9m5ohdAVQhmtiTDcFE+PMQczYx635Vwg@mail.gmail.com>
Content-Language: en-MW
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Seema Pandit <seema.pandit@intel.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, Robert Barror <robert.barror@intel.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 02/07/2019 18:37, Dan Williams wrote:
<>
> 
> I'd be inclined to do the brute force fix of not trying to get fancy
> with separate PTE/PMD waitqueues and then follow on with a more clever
> performance enhancement later. Thoughts about that?
> 

Sir Dan

I do not understand how separate waitqueues are any performance enhancement?
The all point of the waitqueues is that there is enough of them and the hash
function does a good radomization spread to effectively grab a single locker
per waitqueue unless the system is very contended and waitqueues are shared.
Which is good because it means you effectively need a back pressure to the app.
(Because pmem IO is mostly CPU bound with no long term sleeps I do not think
 you will ever get to that situation)

So the way I understand it having twice as many waitqueues serving two types
will be better performance over all then, segregating the types each with half
the number of queues.

(Regardless of the above problem of where the segregation is not race clean)

Thanks
Boaz
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
