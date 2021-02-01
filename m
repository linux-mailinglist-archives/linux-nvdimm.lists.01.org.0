Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A52DB30B31F
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Feb 2021 00:09:51 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 20F4F100EB337;
	Mon,  1 Feb 2021 15:09:50 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=rientjes@google.com; receiver=<UNKNOWN> 
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 47FF3100EB85C
	for <linux-nvdimm@lists.01.org>; Mon,  1 Feb 2021 15:09:48 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id kx7so684816pjb.2
        for <linux-nvdimm@lists.01.org>; Mon, 01 Feb 2021 15:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=3HKABxm2JWW8yXh6Ffuihg4FZgaqjfZi+45jOX+PQQI=;
        b=CcU5cvGUtNpEhVt6Zcu4H5EeWpk+/H7fNLUyevjipbJe31ZbS4kC70stdBy+qRxQuX
         bQGTv/PsDN4g+kKCAXTRJfbaPcAtLtu2g2G7PO0ZEND64tDUuXyPxUHFrUWJ66sQXEKP
         y3nKIvO2CMT9m1Olk6z3pOtYMHnAFGKkus3f9QjH3SfZp3FRkqDGNKcVfBUjYt90JoV5
         PdCs3Zv1/l93Y4WGYJkTJfGuv2R5x64VDgt169TQMxHy81iven1IoQp9Pa1PwE/KPrFi
         owifCbIqzF5y9eiPUjgAXKU14kbZ4PlsribJAgzQV9UBoTMLxogxbFT1vqrRtcyn+Nxm
         BmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=3HKABxm2JWW8yXh6Ffuihg4FZgaqjfZi+45jOX+PQQI=;
        b=UMgP54XXYRc0tAl02+BokevvjAtn7AQdNrk8ulGdriq5dkXTtZrYpX7Rn6S8siubcq
         p+KhTMzXOrdbUbNEejZXk+c/+mtHmLMKZmk0Oif+eEU6hs2Y19d6Ktkf04YAChgLJaCE
         c9RW47jLmqIIz3x23Qx4mV8T+VKaXREsVThPvfNuwJgXFMNtrCpOJbQFCQ6HcQXvlOaj
         BJPkyyeA4ipKs2ioR9+/xaw/lUxrCQq67Dy9bC9/cw/S8XxMyHhYIKkXkwhYTew4IixV
         2+ZV1f5CWR/jv+Frf/I5nQaEEUiuVjv9yoQ97jBl9QwPPlUMugjJJ3yiFvMLiQ5NrcJr
         KBcA==
X-Gm-Message-State: AOAM530JEO0SF/vFaVyKB/yBSCA7Xh1MX0va1N1CzqGo9r67d1a3qUMT
	ZSQTgiCcmxAqemC/bRc5WBpjwsI9zwBRlQ==
X-Google-Smtp-Source: ABdhPJyDaMvGR69SgB9QhG+gcyPBnwjWdXTx/YCd/XS+/X4S/yx5a3E3r1Y0cpZQ0HRKfgAXvzW+NQ==
X-Received: by 2002:a17:902:70c6:b029:df:d62a:8c69 with SMTP id l6-20020a17090270c6b02900dfd62a8c69mr19315852plt.20.1612220986962;
        Mon, 01 Feb 2021 15:09:46 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id j4sm13872905pfa.131.2021.02.01.15.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 15:09:46 -0800 (PST)
Date: Mon, 1 Feb 2021 15:09:45 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH 03/14] cxl/mem: Find device capabilities
In-Reply-To: <20210201225052.vrrvuxrsgmddjzbb@intel.com>
Message-ID: <79b98f60-151b-6c80-65c3-91a37699d121@google.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com> <20210130002438.1872527-4-ben.widawsky@intel.com> <234711bf-c03f-9aca-e0b5-ca677add3ea@google.com> <20210201165352.wi7tzpnd4ymxlms4@intel.com> <32f33dd-97a-8b1c-d488-e5198a3d7748@google.com>
 <20210201215857.ud5cpg7hbxj2j5bx@intel.com> <b46ed01-3f1-6643-d371-7764c3bde4f8@google.com> <20210201222859.lzw3gvxuqebukvr6@intel.com> <20210201223314.qh24uxd7ajdppgfl@intel.com> <f86149f8-3aea-9d8c-caa9-62771bf22cb5@google.com>
 <20210201225052.vrrvuxrsgmddjzbb@intel.com>
MIME-Version: 1.0
Message-ID-Hash: YXBMYXVRXJMSJAJU5LQG4P6MOOAY3AFM
X-Message-ID-Hash: YXBMYXVRXJMSJAJU5LQG4P6MOOAY3AFM
X-MailFrom: rientjes@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YXBMYXVRXJMSJAJU5LQG4P6MOOAY3AFM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 1 Feb 2021, Ben Widawsky wrote:

> > I think that's what 8.2.8.4.3 says, no?  And then 8.2.8.4.5 says you 
> > can use up to Payload Size.  That's why my recommendation was to enforce 
> > this in cxl_mem_setup_mailbox() up front.
> 
> Yeah. I asked our spec people to update 8.2.8.4.5 to make it clearer. I'd argue
> the intent is how you describe it, but the implementation isn't.
> 
> My argument was silly anyway because if you specify greater than 1M as your
> payload, you will get EINVAL at the ioctl.
> 
> The value of how it works today is the driver will at least bind and allow you
> to interact with it.
> 
> How strongly do you feel about this?
> 

I haven't seen the update to 8.2.8.4.5 to know yet :)

You make a good point of at least being able to interact with the driver.  
I think you could argue that if the driver binds, then the payload size is 
accepted, in which case it would be strange to get an EINVAL when using 
the ioctl with anything >1MB.

Concern was that if we mask off the reserved bits from the command 
register that we could be masking part of the payload size that is being 
passed if the accepted max is >1MB.  Idea was to avoid any possibility of 
this inconsistency.  If this is being checked for ioctl, seems like it's 
checking reserved bits.

But maybe I should just wait for the spec update.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
