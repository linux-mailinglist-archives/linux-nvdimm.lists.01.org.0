Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7357412086
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 May 2019 18:48:09 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7FDF921243BD6;
	Thu,  2 May 2019 09:48:07 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com;
 envelope-from=pasha.tatashin@soleen.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 2D3E121243BCA
 for <linux-nvdimm@lists.01.org>; Thu,  2 May 2019 09:48:05 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id b8so2695198edm.11
 for <linux-nvdimm@lists.01.org>; Thu, 02 May 2019 09:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rcAYlClV3WYMLJTodjrLc+GMcN8cBX8qnEYUrl9knag=;
 b=SFbei6R/fTHbrGWi+/N+oWim6SS5KPKvxv1TfgMvbJ1pIR8OajbduDS3nFo+mTzicg
 XVys/It0mRnuhAz4kjM8EiZPi2qESa1Ad7BuVtZXc1AhD6SYmi1WTfMnCEAxTNkaT811
 wtR9FZXA8gRcO+e/pbRwpO9NwRgtNQkNQixypgNzB90FxwHw7uDXDkb5kVruMBFHCmWK
 aDFBzlffvUNDnS4Q6tEIHtK+tlNPSguzMFFvyNwltQHrvgbB4cHlbIie4LsGFzTGdkuJ
 7Yg0FEJD9BqWiLWh/W+DXQN7jVHxZsopXpdlsd205vwlCjzC9uuOvIUXoBsgyR88IvAg
 zT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rcAYlClV3WYMLJTodjrLc+GMcN8cBX8qnEYUrl9knag=;
 b=L46zNyP4GmmhoE8UJxfe7Fmxi2+xhQYDH0dp4gKNqyOni7HFKxO/ksyAMCZQH+asni
 ypa+vtBU6jeuzEIA3CUtM2gPK/+ZwWjFoBRpnA9QxaN1buL3c4oz3ErL6P69D8I4nrdF
 YLsQC4oQcgoXg8KHIENlzXYJIzxcH/P8Lxi64OlIZVx28AeW1U0IVgi2kb4kkFW/TCn8
 vgWuGdGKY5UkJqkAVtsgZG3AL4ym01my2boQPigAe0LEepKafIaBwqaEf1qT729wIJ9T
 G+R+SNa38y9HVQpKE7ObTodX7r8qQ2lxvcLTHCsEXXP6ClD9DcO0J+2DDzBl1cAdG/W3
 +r/A==
X-Gm-Message-State: APjAAAUQNgpkMzWmut6OrdbepadUog8nhtoORPm5I8E8l5kwAJtQ0qlA
 DGF1iwVctGnfr+x1xmg7KCNXfhD3xQm7er83pGLO7Q==
X-Google-Smtp-Source: APXvYqzbaWRuAebout5s4Iqp5ku1hhP9/l4QkLIfxTg/R4+sKpNKvDwBBtR0sOzGL8kxvPpg3HdXxRKpBddZWv64kk8=
X-Received: by 2002:a17:906:3154:: with SMTP id
 e20mr2340820eje.263.1556815683667; 
 Thu, 02 May 2019 09:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190501191846.12634-1-pasha.tatashin@soleen.com>
 <20190501191846.12634-3-pasha.tatashin@soleen.com>
 <CAPcyv4iPzpP-gzuDtPB2ixd6_uTuO8-YdVSfGw_Dq=igaKuOEg@mail.gmail.com>
In-Reply-To: <CAPcyv4iPzpP-gzuDtPB2ixd6_uTuO8-YdVSfGw_Dq=igaKuOEg@mail.gmail.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 2 May 2019 12:47:52 -0400
Message-ID: <CA+CK2bB3G_tO04M1eXPdm4b=OojD6QpYkW51YArj6z44RhQo+g@mail.gmail.com>
Subject: Re: [v4 2/2] device-dax: "Hotremove" persistent memory that is used
 like normal RAM
To: Dan Williams <dan.j.williams@intel.com>
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
Cc: Sasha Levin <sashal@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>,
 Michal Hocko <mhocko@suse.com>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 Takashi Iwai <tiwai@suse.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "Huang, Ying" <ying.huang@intel.com>, James Morris <jmorris@namei.org>,
 David Hildenbrand <david@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Borislav Petkov <bp@suse.de>, Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
 Ross Zwisler <zwisler@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Fengguang Wu <fengguang.wu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

> Currently the kmem driver can be built as a module, and I don't see a
> need to drop that flexibility. What about wrapping these core
> routines:
>
>     unlock_device_hotplug
>     __remove_memory
>     walk_memory_range
>     lock_device_hotplug
>
> ...into a common exported (gpl) helper like:
>
>     int try_remove_memory(int nid, struct resource *res)
>
> Because as far as I can see there's nothing device-dax specific about
> this "try remove iff offline" functionality outside of looking up the
> related 'struct resource'. The check_devdax_mem_offlined_cb callback
> can be made generic if the callback argument is the resource pointer.

Makes sense, I will do both things that you suggested.

Thank you,
Pasha
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
