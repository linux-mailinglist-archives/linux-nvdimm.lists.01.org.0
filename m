Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 256C85F8B3
	for <lists+linux-nvdimm@lfdr.de>; Thu,  4 Jul 2019 15:00:09 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7DC3D212B0810;
	Thu,  4 Jul 2019 06:00:07 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com;
 envelope-from=openosd@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B7565212AF0CB
 for <linux-nvdimm@lists.01.org>; Thu,  4 Jul 2019 06:00:05 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id e3so5335380edr.10
 for <linux-nvdimm@lists.01.org>; Thu, 04 Jul 2019 06:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=W3YX4qyiQ8io0QlAlJhhQ1BpPb12I9CxfxqXtbQ0TLk=;
 b=E3JZ9ogcwZlSvahnLgdA879/a0BsQcwPHH8vTp1K3ZWV/6I7UECgSepeJxMFSdGRtg
 gKLM/46akrIUDBGrhZvZyVB9uCmyyK53zrTd2seYk7/zWRwSesJl3dD2cor46695IDfd
 sk6F0r8vJ2WiV53oqyU0ecCX6mh8yaCMltvd+oMts+ccs/hHClYdLKBWKBhBRZ6dv+Y1
 sK23uPIZUQ0jPFIyUIicscj90bg8F70bxeuaugKdC1vC/WrOM79YujMTmmBlp5bqVVQS
 0dnbKogj+GCwz60Ok3miQDyMjnm9n49s58WLI7UrJ71L25mrumXbsypWphmqfP6vGxDq
 arJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=W3YX4qyiQ8io0QlAlJhhQ1BpPb12I9CxfxqXtbQ0TLk=;
 b=QBJ2cOBJhG3b+09yjngkc7JJF6H2y7wnoCsUoG9VIuPvHvTHW5+2LrgoxYrq20hoaC
 KPWzGV2d584YS0iLHdCDac0LdDDIMZYnnrMaSShTZ6+ytWFF8n4ZM3+UaY0w+nwRdTZz
 XxUW7YudSNQQ4ERtoHrA3EQ+RkdW3m14A+pghTgx0KlZdMhc4JBvp+2X8TaF3vEr/CNZ
 0tUrQ5UAQnuaf+hYlYnkBEKRpDqOvas2WioBrT8S8ii4gC7rL1pTo8clsQ/efrJFlwf3
 T3/EQA1VGC1rU0448KYJPNtfbGcxLPzAUOAe6Bpn3ARK6VTeyaLxMdYm3ccFIVEwx9SG
 0R5g==
X-Gm-Message-State: APjAAAXa6K8ULk9iM+a7KKH63J5duZRY9BWUJkF77hBKPE2Ckn8wq4Tl
 +ItEu+I66ZsWyGgEhMUKcOs=
X-Google-Smtp-Source: APXvYqx/xDpW63P0DtWVWg5EHGUMTzL2ZtFT2OlGJ9vaEeS2E3Ny8vNG//RYrRCWQ9JPOE/XXajuDQ==
X-Received: by 2002:a17:906:d7ab:: with SMTP id
 pk11mr39519655ejb.216.1562245204270; 
 Thu, 04 Jul 2019 06:00:04 -0700 (PDT)
Received: from [10.68.217.182] ([217.70.211.18])
 by smtp.gmail.com with ESMTPSA id z12sm1595238edq.57.2019.07.04.06.00.02
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Jul 2019 06:00:03 -0700 (PDT)
Subject: Re: [PATCH] dax: Fix missed PMD wakeups
To: Matthew Wilcox <willy@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>
References: <156213869409.3910140.7715747316991468148.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190703121743.GH1729@bombadil.infradead.org>
 <CAPcyv4jgs5LTtTXR+2CyfbjJE85B_eoPFuXQsGBDnVMo41Jawg@mail.gmail.com>
 <20190703195302.GJ1729@bombadil.infradead.org>
 <CAPcyv4iPNz=oJyc_EoE-mC11=gyBzwMKbmj1ZY_Yna54=cC=Mg@mail.gmail.com>
 <20190704032728.GK1729@bombadil.infradead.org>
From: Boaz Harrosh <openosd@gmail.com>
Message-ID: <f23a1c71-d1b1-b279-c922-ce0f48cb4448@gmail.com>
Date: Thu, 4 Jul 2019 16:00:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190704032728.GK1729@bombadil.infradead.org>
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

On 04/07/2019 06:27, Matthew Wilcox wrote:
> On Wed, Jul 03, 2019 at 02:28:41PM -0700, Dan Williams wrote:
<>
>>> +#ifdef CONFIG_XARRAY_MULTI
>>> +       unsigned int sibs = xas->xa_sibs;
>>> +
>>> +       while (sibs) {
>>> +               order++;
>>> +               sibs /= 2;
>>> +       }
>>
>> Use ilog2() here?
> 
> Thought about it.  sibs is never going to be more than 31, so I don't
> know that it's worth eliminating 5 add/shift pairs in favour of whatever
> the ilog2 instruction is on a given CPU.  In practice, on x86, sibs is
> going to be either 0 (PTEs) or 7 (PMDs).  We could also avoid even having
> this function by passing PMD_ORDER or PTE_ORDER into get_unlocked_entry().
> 
> It's probably never going to be noticable in this scenario because it's
> the very last thing checked before we put ourselves on a waitqueue and
> go to sleep.
> 

Matthew you must be kidding an ilog2 in binary is zero clocks
(Return the highest bit or something like that)

In any way. It took me 5 minutes to understand what you are doing
here. And I only fully got it when Dan gave his comment. So please for
the sake of stupid guys like me could you please make it ilog2() so
to make it easier to understand?
(And please don't do the compiler's job. If in some arch the loop
 is the fastest let the compiler decide?)

Thanks
Boaz
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
