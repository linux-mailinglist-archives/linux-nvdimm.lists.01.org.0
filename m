Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DB9207F12
	for <lists+linux-nvdimm@lfdr.de>; Thu, 25 Jun 2020 00:02:00 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2D58710FCC8FB;
	Wed, 24 Jun 2020 15:01:59 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com; envelope-from=rientjes@google.com; receiver=<UNKNOWN> 
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3DC2610FCC6CB
	for <linux-nvdimm@lists.01.org>; Wed, 24 Jun 2020 15:01:56 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id p3so2139609pgh.3
        for <linux-nvdimm@lists.01.org>; Wed, 24 Jun 2020 15:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=JtnqSIsBj/BF7IGUdXeNN8kYdqMgoQN65lThbV8+e0I=;
        b=rZelCg0YbzRPlv5V+vuWn7sHK13srbX1cO1mAPMUgY5O2vjHkTVamQ63cuzjEo1okr
         VGoq/xvgXtW3T7rM8FoDdrggIP/BCOiG/fcMJRE3z0VeakJmfqLp0FeDoqudgXv1QGM8
         UFGOCWRbR2wWAx6C7coZTrMeJ4kuXqKqNUr580acWMdtPZVJNA4fy7FYZ+XtCZW4P+pa
         Mm2w5QoqcmG4/HU8jywfTVydwWgqTeykuOz3lQJsuL6gxMj7TG8cZOFrieNwyBnFcgvN
         htocwK4LkAGiIufTQ49KIumINcO7+IqKdoTELynNMvsv30ZWFNSGphyTBqrD1pEOBpk9
         hmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=JtnqSIsBj/BF7IGUdXeNN8kYdqMgoQN65lThbV8+e0I=;
        b=SevOlDEdHjH5ME2yThMwzQjAOUhGnDx1K3EX6FtG0End4nkKTNW2c9YeZaKes4AGm0
         AZbmqxnx0VL1YpkrJSiTyRoCF5ohs+BDydFQmDiWs9ckQhUNOg25xyULG9m5d/Uy4pnj
         0dMvKN6D4Y+U5I5qOyOmEvymvY2J6R2+Yk2+fZOQvleeZ1tgxyDyQIq1O6crwX1AdySJ
         jbmLvgrjZn0ca9pcrXXNB5IXpx4gN4xdphiOoYgYCxm8ir7uDFiByZQ+MGZxVRANX6s4
         Iu+yJV85IF7SLLjenZJ2ftVfYb4JXrO5IPqXloD/5Y6icF0PrUNCsE8YJgVdWTDTS2WU
         GQkA==
X-Gm-Message-State: AOAM5319vN1b9GL4yfbVvjid7UM27go72yF1zqxrhlTo3RqJEd2QsZfO
	h0l8/UhQZ+ty+O3MQSzSdhVjzw==
X-Google-Smtp-Source: ABdhPJw0lsYH2vvdsw13COy6bxZEFzIg7Dt5qMmJFPNgfCeGO7YHrLsda6vxpHhbi8XYyIdvwHcfiA==
X-Received: by 2002:aa7:9105:: with SMTP id 5mr3283028pfh.199.1593036115064;
        Wed, 24 Jun 2020 15:01:55 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id u26sm7814361pgo.71.2020.06.24.15.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 15:01:54 -0700 (PDT)
Date: Wed, 24 Jun 2020 15:01:53 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Jane Chu <jane.chu@oracle.com>
Subject: Re: [RFC] Make the memory failure blast radius more precise
In-Reply-To: <19ffec14-28c7-fddc-3042-6ccb8d4e83fa@oracle.com>
Message-ID: <alpine.DEB.2.22.394.2006241459540.62172@chino.kir.corp.google.com>
References: <20200623201745.GG21350@casper.infradead.org> <20200623220412.GA21232@agluck-desk2.amr.corp.intel.com> <alpine.DEB.2.22.394.2006232114100.97817@chino.kir.corp.google.com> <19ffec14-28c7-fddc-3042-6ccb8d4e83fa@oracle.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Message-ID-Hash: YHWR2O7OANRC675P73YK7EHIQKAGUG45
X-Message-ID-Hash: YHWR2O7OANRC675P73YK7EHIQKAGUG45
X-MailFrom: rientjes@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Luck, Tony" <tony.luck@intel.com>, Mike Kravetz <mike.kravetz@oracle.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Matthew Wilcox <willy@infradead.org>, Borislav Petkov <bp@alien8.de>, Naoya Horiguchi <naoya.horiguchi@nec.com>, linux-edac@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, "Darrick J. Wong" <darrick.wong@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YHWR2O7OANRC675P73YK7EHIQKAGUG45/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 24 Jun 2020, Jane Chu wrote:

> Hi, David,
> 
> On 6/23/2020 9:32 PM, David Rientjes wrote:
> > I don't want to hijack Matthew's thread which is primarily about DAX, but
> > did get intrigued by your concerns about hugetlbfs page poisoning.  We can
> > fork the thread off here to discuss only the hugetlb application of this
> > if it makes sense to you or you'd like to collaborate on it as well.
> 
> hugetlbfs is not supported in DAX, are you planning to add support?
> 

No, sorry, I was replying only about Tony's comment about the current page 
poisoning behavior for hugetlbfs and brainstorming a way that we could 
reduce the memory failure blast radius for hugetlb pages if we had the 
doublemap support that would also be useful for post-copy live migration.

It's independent of DAX so I'm happy to fork this topic off into a 
different thread for the hugetlb discussion.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
