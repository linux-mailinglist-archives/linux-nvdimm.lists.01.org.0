Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A506E5FA1F
	for <lists+linux-nvdimm@lfdr.de>; Thu,  4 Jul 2019 16:32:30 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3799E212B0818;
	Thu,  4 Jul 2019 07:32:29 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com;
 envelope-from=openosd@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C3074212B0809
 for <linux-nvdimm@lists.01.org>; Thu,  4 Jul 2019 07:32:27 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id i11so5628844edq.0
 for <linux-nvdimm@lists.01.org>; Thu, 04 Jul 2019 07:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hG94lb2mfNpipyjyuBXQyz3ZoROecI4LdyTS4Vj1aUM=;
 b=XA9XKA4yi6IQLxDBOZSLzJDJ1P24RGWiALToGJfWjOvu6I+Lke7v4PE6vpt4zTO45f
 KiGPVmx1c1YtAzr2WZyJp0525y0uUiM0nG9LLRg6mxDNCw6Xjp57vDWhre5xVltjNySp
 f8Kfe+ewF1z6ILjMGeW6+dSFXbKC6OMpbRdbLLXxVMTBh5vM6N1C3hDZs5renLsWJYFu
 9ZITRK7Bq4lRDxMwAHxLE18gAr8rESKdd5uHipVnCKM2I/iaZ66fShyrSwZuIKR2f0G4
 eoPyMPB/TzopgZTTNzImjgnkfQ6OHld219zrdZGZLVZ0mATlt7Ix7UlE54yZgAgYouJV
 SU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hG94lb2mfNpipyjyuBXQyz3ZoROecI4LdyTS4Vj1aUM=;
 b=HhGCpLDppxNQVxQEcyyW6ZX//5OQssDvLG+Ol19c9j6y/8+6zttC+dIraTcXK5zIyh
 n3r0uulP/bzs4GqP0pciWkVXOtw90K54TxkeXCVevkfxoUrrRdXsTg0qwWbESk/MsdYB
 W1DKmP08qCIyWfJeKcYr0v1ORaEiUqo77urv9Yz5i/NzuQfiVp11pj+28+OwGdF5QM6M
 GMC1Ld2Cl0aPrP8vJnhj+PWNPlpg7mvX8ryszJKO9gePHj0KlOGEA9p0WAUZDVb6Jq1t
 GG1+Axx8xOgQcibZ4ItZiQAVnj+Sve0vrABtmf/MZpwyU4UdYVhUQBx5PXzgOiXywM5b
 OioQ==
X-Gm-Message-State: APjAAAWMJas1JvY76465/vUF8x27pdSARmN1y7bqM2NSTpCxLR80x4Be
 h+LX3IW2LY82irP2yF2gi0o=
X-Google-Smtp-Source: APXvYqzT2XlfYr+uxPrC/zJOphkRAdeGPMcKImu0CzVFB9O9lFTTq1YMhHbw65sOeQXrNnJ2ydEjqA==
X-Received: by 2002:a17:906:1f43:: with SMTP id
 d3mr29380618ejk.169.1562250745941; 
 Thu, 04 Jul 2019 07:32:25 -0700 (PDT)
Received: from [10.68.217.182] ([217.70.211.18])
 by smtp.gmail.com with ESMTPSA id x10sm1708831edd.73.2019.07.04.07.32.24
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Jul 2019 07:32:25 -0700 (PDT)
Subject: Re: [PATCH] dax: Fix missed PMD wakeups
To: Matthew Wilcox <willy@infradead.org>
References: <156213869409.3910140.7715747316991468148.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190703121743.GH1729@bombadil.infradead.org>
 <CAPcyv4jgs5LTtTXR+2CyfbjJE85B_eoPFuXQsGBDnVMo41Jawg@mail.gmail.com>
 <20190703195302.GJ1729@bombadil.infradead.org>
 <CAPcyv4iPNz=oJyc_EoE-mC11=gyBzwMKbmj1ZY_Yna54=cC=Mg@mail.gmail.com>
 <20190704032728.GK1729@bombadil.infradead.org>
 <f23a1c71-d1b1-b279-c922-ce0f48cb4448@gmail.com>
 <20190704135804.GL1729@bombadil.infradead.org>
From: Boaz Harrosh <openosd@gmail.com>
Message-ID: <bfe7c33d-7c3c-dcc0-5408-e23ea8223ef0@gmail.com>
Date: Thu, 4 Jul 2019 17:32:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190704135804.GL1729@bombadil.infradead.org>
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
Cc: Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, Robert Barror <robert.barror@intel.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Seema Pandit <seema.pandit@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 04/07/2019 16:58, Matthew Wilcox wrote:
> On Thu, Jul 04, 2019 at 04:00:00PM +0300, Boaz Harrosh wrote:
<>
>> Matthew you must be kidding an ilog2 in binary is zero clocks
>> (Return the highest bit or something like that)
> 
> You might want to actually check the documentation instead of just
> making shit up.
> 

Yes you are right I stand corrected. Must be smoking ;-)

> https://www.agner.org/optimize/instruction_tables.pdf
> 
> I think in this instance what we want is BSR (aka ffz) since the input is
> going to be one of 0, 1, 3, 7, 15 or 31 (and we want 0, 1, 2, 3, 4, 5 as
> results).
> 
<>
> The compiler doesn't know the range of 'sibs'.  Unless we do the
> profile-feedback thing.
> 

Would you please consider the use of get_order() macro from #include <getorder.h>
Just for the sake of understanding? (Or at least a comment)

Thanks
Boaz
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
