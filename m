Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4EF11D255
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Dec 2019 17:31:56 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4DCD01011363F;
	Thu, 12 Dec 2019 08:35:17 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::842; helo=mail-qt1-x842.google.com; envelope-from=brho@google.com; receiver=<UNKNOWN> 
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9035F1011332F
	for <linux-nvdimm@lists.01.org>; Thu, 12 Dec 2019 08:35:15 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id k40so1072172qtk.8
        for <linux-nvdimm@lists.01.org>; Thu, 12 Dec 2019 08:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5nxGnUdtw58bWHogUzbvsjBU/PDGHKaobG6uElnGLno=;
        b=oa9rL5G/dbfnIV/LzrzoNnyRhtYmlptMoi+t69zugwSNSWgp9blS+XEl+9/0hsU8g4
         wEvlkxhrXfv//LqB2RXF1LitoGfhsbCkWj/Z5CkEmM96cg+UQbdGImwjCbcHoIJMMNj+
         sljAkxcEM8qhYEWlMb93V1Xx85g7RTRnV35Wu3xroUX1iVIdvJLWKvrBy79W0q0hUiVi
         X3/dugi+HFn6kRO6XlCj5Wu2KE6/5NrV285cbLrOGt6N6OYzb6ULcMDIc/F6pZ2s7ZbE
         VSVXgaZMKyImgmEl28wIXQzlvsJ5qIjNjk1tyKd4jJLcuPBrdarAFLv/PrC8tUBEusL0
         wt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5nxGnUdtw58bWHogUzbvsjBU/PDGHKaobG6uElnGLno=;
        b=Xdrb/so2j9FLas6XnFg4X+dZqydIid5RKWDzzs+mvSVoqZIZFJ2dO8mF0urTyyOjMf
         wJl+s6RlTq85QjBJT3o5JNhcojs7ibiNXwJ3U1uuaAhrK+4as/Y76YWgMOUyCT8kAvDj
         HxNUhVVoGt7BLd2iZzUwS3/o4YfqRh+Qn2i3fcW0g0DSRF+pUXv0rjf2jRQy36e7GyJh
         YPYXyCWiCgjLI1pQyBBVE4ojKyxXvgrFFCZZOXOHpXm6kOTkTA5nLppLgQX0kf6He7P1
         DQTHmRbgJR3+Aglzn5l3jjMRHgYeSwKR4Z1XoJQNeANnRaqGdw9654KO2Rv3w+vgnIZT
         eySw==
X-Gm-Message-State: APjAAAVrkJXtLI2TA4d1DkFXQMoQyMR0fpiMMjp35z5KRZpOkgec8i7M
	Qe0DaL0a76zXHIylr6J85RaTsA==
X-Google-Smtp-Source: APXvYqyfo7q7u1Qo2RWrsYPgxg4cCPsnEGuVFjYRp2T2M/zKAnej0anX24hFu358xW7EyeiV/RdLyw==
X-Received: by 2002:ac8:3177:: with SMTP id h52mr8535747qtb.264.1576168311701;
        Thu, 12 Dec 2019 08:31:51 -0800 (PST)
Received: from ?IPv6:2620:0:1004:a:6e2b:60f7:b51b:3b04? ([2620:0:1004:a:6e2b:60f7:b51b:3b04])
        by smtp.gmail.com with ESMTPSA id t38sm2355441qta.78.2019.12.12.08.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 08:31:51 -0800 (PST)
Subject: Re: [PATCH v4 2/2] kvm: Use huge pages for DAX-backed files
To: David Hildenbrand <david@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>
References: <20191211213207.215936-1-brho@google.com>
 <20191211213207.215936-3-brho@google.com>
 <eb9ef218-1bbc-83e6-ec84-c6aae245e62b@redhat.com>
From: Barret Rhoden <brho@google.com>
Message-ID: <c203f44c-d5b0-429d-0c13-5723c09ec243@google.com>
Date: Thu, 12 Dec 2019 11:31:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <eb9ef218-1bbc-83e6-ec84-c6aae245e62b@redhat.com>
Content-Language: en-GB
Message-ID-Hash: YX7KHPWMOS66GZC4OVKJ2NV5EUMLTJC7
X-Message-ID-Hash: YX7KHPWMOS66GZC4OVKJ2NV5EUMLTJC7
X-MailFrom: brho@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jason.zeng@intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YX7KHPWMOS66GZC4OVKJ2NV5EUMLTJC7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 12/12/19 7:22 AM, David Hildenbrand wrote:
>> +	/*
>> +	 * Our caller grabbed the KVM mmu_lock with a successful
>> +	 * mmu_notifier_retry, so we're safe to walk the page table.
>> +	 */
>> +	switch (dev_pagemap_mapping_shift(hva, current->mm)) {
>> +	case PMD_SHIFT:
>> +	case PUD_SIZE:
> 
> Shouldn't this be PUD_SHIFT?
> 
> But I agree with Paolo, that this is simply
> 
> return dev_pagemap_mapping_shift(hva, current->mm) > PAGE_SHIFT;

Yes, good call.  I'll fix that in the next version.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
