Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DDC2914CC
	for <lists+linux-nvdimm@lfdr.de>; Sat, 17 Oct 2020 23:38:36 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3827E1581B08E;
	Sat, 17 Oct 2020 14:38:34 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::f41; helo=mail-qv1-xf41.google.com; envelope-from=konstantin@linuxfoundation.org; receiver=<UNKNOWN> 
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7817A1581B08C
	for <linux-nvdimm@lists.01.org>; Sat, 17 Oct 2020 14:38:31 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id t6so2676614qvz.4
        for <linux-nvdimm@lists.01.org>; Sat, 17 Oct 2020 14:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DpiCvleRFqkCK/fDfZ7fp+hAu6jhnoAgHb1I8QYfciw=;
        b=fXCGvQdVXoRNSS+zLvw3CVNdgjqQsVcO9j20JUaDdhgScv6u3EfcRImngY/9NyTdmr
         1ddSPudK5EGTTdXMiUXLCYVt3EukeJCm+TWatSq6nbGLjKpuhGLXbV4cijuKgJI0t1rX
         lI8fNeyR432T1tBuB8YZM2XOCd0A2n3fhSryk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DpiCvleRFqkCK/fDfZ7fp+hAu6jhnoAgHb1I8QYfciw=;
        b=fZdmC3a+UrXrZIf1ENmBDbel5Xn6Oc/IKeejpCnFh+cJ2FxGLlUqbhDWy3cNbKdKWB
         F/QaUpeJeV3G4SVNUrrKDgoAloq/5Kvpqp5n7i8HDn6CJN6XtQGtKUFTZfYjL4zgll2L
         +QSi+DIVDWJGpJf2lenlcFZIkWm7MhxEkeWgguGi2RNq7z/vCV/S2uqnCalzbs3M4Mtb
         4cP6M9cahBCozgzLlYESzMC0NE8cI9rutY3carY65BE7488i5RyBEmdfcH2uSBQoE1qk
         8+/eSItK7iUgLML4TLqpV+FJnZt0BWw6kXxCvzwGJrmcGwQ9S7sP6PtOxqBKiFuhbLIM
         vHQQ==
X-Gm-Message-State: AOAM532x95ZTgYPCLf64Tu9KG8t5ckOWcuOXFjpV7nKFyCIZOs/t6WHt
	49cTuIBLcx92+bQLkwACeZo7lg==
X-Google-Smtp-Source: ABdhPJyLsezU3KU9yk22xT3Hk3Iz8IexpAnlxDcSJcd4TtvsgQQQGQEqZatXQwqxasgGcm5fQ3BDgQ==
X-Received: by 2002:ad4:4141:: with SMTP id z1mr10456018qvp.33.1602970709509;
        Sat, 17 Oct 2020 14:38:29 -0700 (PDT)
Received: from chatter.i7.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id g15sm869731qki.107.2020.10.17.14.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 14:38:29 -0700 (PDT)
Date: Sat, 17 Oct 2020 17:38:25 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] device-dax/kmem: Use struct_size()
Message-ID: <20201017213825.vwefgw7n6txj2hho@chatter.i7.local>
References: <160288261564.3242821.6055291930923876456.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAHk-=wg_HafvgLvyHcYk=K-gJFdj9aqap4At7DCFyroLVC04LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=wg_HafvgLvyHcYk=K-gJFdj9aqap4At7DCFyroLVC04LQ@mail.gmail.com>
Message-ID-Hash: 3AOASK3AB6W4UWDAR7J5SFAP6N3RL4QS
X-Message-ID-Hash: 3AOASK3AB6W4UWDAR7J5SFAP6N3RL4QS
X-MailFrom: konstantin@linuxfoundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3AOASK3AB6W4UWDAR7J5SFAP6N3RL4QS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Oct 17, 2020 at 11:38:32AM -0700, Linus Torvalds wrote:
> > Link: 
> > http://lore.kernel.org/r/CAHk-=wgNTLbvAD8mNTvh+GQyapNWeX20PXhU_+frqEvVq4298w@mail.gmail.com
> 
> Does that link work for you?
> 
> Because I can't see it.
> 
> In fact, I don't see my email at all on lore, even if I see Andrew's
> email that I answered to:
> 
>     https://lore.kernel.org/mm-commits/20201016024059.Ycwm4GmQ8%25akpm@linux-foundation.org/
> 
> but your link gives me "Not Found", and when I search for emails from
> me on mm-commits I don't see them either.
> 
> Adding Konstantin just to solve the mystery. Some odd mirroring
> problem, perhaps?

I don't really have any insights here, unfortunately. Judging from 
conversations I see on IRC, I gather that vger had another outage 
earlier today, so chances are that your email will eventually get 
delivered and will start showing up on lore.kernel.org. Right now, we 
have no record of a message with that message-id traversing 
archiver.kernel.org.

(Vger is historically maintained by a different set of people from the 
rest of kernel.org, so I have no access or visibility to trace 
situations like that. If folks wanted to review the current arrangement, 
I'm sure the Linux Foundation would be willing to roll it into the rest 
of the infrastructure to be managed by the same LF IT team. I don't want 
to impose anything here, though, so this would need to be initiated by 
the community and with full agreement of current vger administrators.)

-K
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
