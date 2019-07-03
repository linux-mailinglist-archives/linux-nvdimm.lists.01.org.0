Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3AF5DB07
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Jul 2019 03:39:46 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 17C54212AC492;
	Tue,  2 Jul 2019 18:39:45 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com;
 envelope-from=openosd@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B1EA2212AC48B
 for <linux-nvdimm@lists.01.org>; Tue,  2 Jul 2019 18:39:42 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id k8so401828eds.7
 for <linux-nvdimm@lists.01.org>; Tue, 02 Jul 2019 18:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xv6Z2w7AXk92Vbzt4aqL4v0EY5bcvUni5jxfgnSS2X4=;
 b=vBiIeW9bFNunEW4y2IugAzdpjTePbxfP9J0ybTq2bnsVP4Fl7QW61pngKWqUIUrJt/
 opaKadhTBaDLpSqKWyixYloIWQhFCJra8GnQDDW8enxAC2D7aSo+Vq+kHtMkqBlUJgza
 in7TNAfvTg5HFSU4kHEJzR4/GmcTAKClwzCMBJ7GkmUsmHxlH0LXaUrjMRxFEFt2agmV
 goKHC8epixWBWZTWq6GPfRm04jTfVeUnTBJr68JsqS3B5VGX/vciNpVVVxTyEH095Hl4
 1Dtm8Uz1BSDW1fhfnC1aHFjWq1rp9oyo0mRXe25G+4cKWGSZUqYrUQ7Y91B0WzzMG/xY
 d+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xv6Z2w7AXk92Vbzt4aqL4v0EY5bcvUni5jxfgnSS2X4=;
 b=plm2hTJEg9M5DczkmSADNW/6UUBe9GmkQlKCNUTKXUzMkyAYGn52kFE6G0iNTrSqrs
 brwpgcbbH9hu46MM102IgdVaSH9XUpFTK9KFm7lNgG2gNrkePLKbQNd2LZZkwCoyH8XA
 rccwJ0KYzurncbWD4EjZx/dL/3U2yBKLjkS2FdGI99xYjC1MSq9N+QrJPJ5KG1I2F36+
 pqkIIGhyTvFeJf4159L1RsViLPOGMmVgPHgLtKakwyrOYjtqCUwZyc7LfRKcKO/1vvPb
 +ZyqmtlEpgkpSgT52q+TuK4xb7VBzLoCC6AtCyywkXhrHICCXlmSUF4KKwkbosciwYTF
 C0iQ==
X-Gm-Message-State: APjAAAVE7REwZQsaOfFn/nTKOEUIcbzjXj8EFJu3N8G5f1H8FICKjlu5
 qUOC1s7ljiMle31LW1F1xJY=
X-Google-Smtp-Source: APXvYqwrLtCnEUAfps9E5gDVqiIlzIoWVwm2iRYk7xzsJoj47a3BVX1i6951g0EonpzWMlMC/XccCA==
X-Received: by 2002:a50:f4dd:: with SMTP id v29mr39081283edm.246.1562117981276; 
 Tue, 02 Jul 2019 18:39:41 -0700 (PDT)
Received: from [10.68.217.182] ([217.70.211.18])
 by smtp.gmail.com with ESMTPSA id l50sm212064edb.77.2019.07.02.18.39.39
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Jul 2019 18:39:40 -0700 (PDT)
Subject: Re: [PATCH] filesystem-dax: Disable PMD support
To: Dan Williams <dan.j.williams@intel.com>
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
 <fa9b9165-7910-1fbd-fb5b-78023936d2f2@gmail.com>
 <CAPcyv4ihQ9djQvgnqZoTLRH3CwFhpWK_uUrmWSLH_3-Fi1g1qw@mail.gmail.com>
From: Boaz Harrosh <openosd@gmail.com>
Message-ID: <1eac7cfb-a23c-097e-8dba-d83e6921f152@gmail.com>
Date: Wed, 3 Jul 2019 04:39:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4ihQ9djQvgnqZoTLRH3CwFhpWK_uUrmWSLH_3-Fi1g1qw@mail.gmail.com>
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
 Matthew Wilcox <willy@infradead.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 03/07/2019 03:42, Dan Williams wrote:
> On Tue, Jul 2, 2019 at 5:23 PM Boaz Harrosh <openosd@gmail.com> wrote:
<>
> 
> Yes, but the trick is how to manage cases where someone waiting on one
> type needs to be woken up by an event on the other. 

Exactly I'm totally with you on this.

> So all I'm saying it lets live with more hash collisions until we can figure out a race
> free way to better scale waitqueue usage.
> 

Yes and lets actually do real measurements to see if this really hurts needlessly.
Maybe not so much

Thanks
Boaz

<>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
