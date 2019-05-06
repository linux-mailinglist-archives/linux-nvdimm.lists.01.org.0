Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2CF1533D
	for <lists+linux-nvdimm@lfdr.de>; Mon,  6 May 2019 20:01:30 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6DC5121250C96;
	Mon,  6 May 2019 11:01:28 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 567522121AA3A
 for <linux-nvdimm@lists.01.org>; Mon,  6 May 2019 11:01:27 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id l17so2790287otq.1
 for <linux-nvdimm@lists.01.org>; Mon, 06 May 2019 11:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=s1iYiXewvQHx5myE/g1Y4h4JHD9obTw48tmYZs0bXqI=;
 b=Gesm1Mat5Nvdr9Z6ppAbheRkkXki5hmEJfki+aAZEgQWtXeZOTMMrgHdcrUMVJlQDM
 EoFBqW0epQyBVW0aMfUQWMZnSCnDG8Y/vtE5zcyaAH6Zdl9pu/EraJnHe6FBYcMXyLyp
 VZWggnrv7fI/MHQOhvLueK8w7k5e1LgXjHwFDufU47j2WbehxdNld3it11T/RfmzXJrP
 ljgYCI7GsW9S1KDe1lCVZ4mK3cyWa3kT8S9i8NiXyvnLEBSmbjhWarFP7+6KuIOEkME3
 7O9VFfUN9zNq29/cUxKNj4nEuJwTTMN48lYv1nIyegLPGtL2vWXAzQYZsJ+V1TQeTBnW
 0sdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=s1iYiXewvQHx5myE/g1Y4h4JHD9obTw48tmYZs0bXqI=;
 b=qyfMhgl+8gUJbMpx1cdBg1mrfII6Bf1YUlZLGczG0FBQf4lPEt3xckQLPIxiU4MM8K
 eVvn1FTqoflI3lJjWPJF91CFAiP+gYrrs8orLum6B7ImgLvaB3ig01YVNJ/Gk6dkYTBu
 63r46IlObn6tM9VyTYCgngpdXzae/rR1KB5rD4u3Sy+33CDpeqcs5s+PJCKtoCCyiW+g
 udmvNrz/I8jPIRSfyT+eIqk9i4ZQ7CNCj8AvBM7aozyfGYED5k3+0oRVH/6jWDyxBAsM
 W97wIbV3CvRzPYkMBSbnJWbbuM/sp2AEDkcqij8oxaVkrpY1LYbirBGL0IFKGza4U40C
 4DZg==
X-Gm-Message-State: APjAAAWpWTnacW2aWAX1XO87M7Ru9HhZxBaBMTUmJp1UvEz3K5ex/t9b
 D4dilNqCFCFxY5rTTE8C9pAdjAMDDPFSqPqc49pjkQ==
X-Google-Smtp-Source: APXvYqyX9nJzOdD3XQZPHP+tb9t4162dRKXqMf2zXk6saJvTjLay55UFP+hEuwJnc0ji6oilX5u1sKGnO6ke6FVIfL4=
X-Received: by 2002:a9d:7ad1:: with SMTP id m17mr17304018otn.367.1557165685323; 
 Mon, 06 May 2019 11:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190502184337.20538-1-pasha.tatashin@soleen.com>
 <20190502184337.20538-3-pasha.tatashin@soleen.com>
 <cac721ed-c404-19d1-71d1-37c66df9b2a8@intel.com>
In-Reply-To: <cac721ed-c404-19d1-71d1-37c66df9b2a8@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 6 May 2019 11:01:14 -0700
Message-ID: <CAPcyv4greisKBSorzQWebcVOf2AqUH6DwbvNKMW0MQ5bCwYZrw@mail.gmail.com>
Subject: Re: [v5 2/3] mm/hotplug: make remove_memory() interface useable
To: Dave Hansen <dave.hansen@intel.com>
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
Cc: Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>,
 Takashi Iwai <tiwai@suse.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Linux MM <linux-mm@kvack.org>, Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
 Ross Zwisler <zwisler@kernel.org>, Sasha Levin <sashal@kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, James Morris <jmorris@namei.org>,
 "Huang, Ying" <ying.huang@intel.com>, Borislav Petkov <bp@suse.de>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Pavel Tatashin <pasha.tatashin@soleen.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Fengguang Wu <fengguang.wu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, May 6, 2019 at 10:57 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> > -static inline void remove_memory(int nid, u64 start, u64 size) {}
> > +static inline bool remove_memory(int nid, u64 start, u64 size)
> > +{
> > +     return -EBUSY;
> > +}
>
> This seems like an appropriate place for a WARN_ONCE(), if someone
> manages to call remove_memory() with hotplug disabled.
>
> BTW, I looked and can't think of a better errno, but -EBUSY probably
> isn't the best error code, right?
>
> > -void remove_memory(int nid, u64 start, u64 size)
> > +/**
> > + * remove_memory
> > + * @nid: the node ID
> > + * @start: physical address of the region to remove
> > + * @size: size of the region to remove
> > + *
> > + * NOTE: The caller must call lock_device_hotplug() to serialize hotplug
> > + * and online/offline operations before this call, as required by
> > + * try_offline_node().
> > + */
> > +void __remove_memory(int nid, u64 start, u64 size)
> >  {
> > +
> > +     /*
> > +      * trigger BUG() is some memory is not offlined prior to calling this
> > +      * function
> > +      */
> > +     if (try_remove_memory(nid, start, size))
> > +             BUG();
> > +}
>
> Could we call this remove_offline_memory()?  That way, it makes _some_
> sense why we would BUG() if the memory isn't offline.

Please WARN() instead of BUG() because failing to remove memory should
not be system fatal.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
