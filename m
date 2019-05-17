Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5693D21C5B
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 May 2019 19:22:18 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 741002125F1CC;
	Fri, 17 May 2019 10:22:16 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=pasha.tatashin@soleen.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4309A212532E1
 for <linux-nvdimm@lists.01.org>; Fri, 17 May 2019 10:22:14 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id a8so11627645edx.3
 for <linux-nvdimm@lists.01.org>; Fri, 17 May 2019 10:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1NWuugkWpQRRWA/1rSmW1lzMgKVNslNjLRYEkdR1Nr8=;
 b=le6/IjvKmu1b5/J+EeSLlKWUQDlzA2Aar3VHLn8ExShqMsFCKjqEBf+toX4TliPE0H
 eb+VONE8jljaQgC23HLZmR5QS5UHQ14s4T0FxyYIFc1hvnC7sseb5WD9AvBCBynEFdA1
 lrQnNndD0CS9PvrNd4djxjYrHkGXrpWHkuZzQhKz2o77NRvXkFxRo3BMupdD9bP4JwDh
 yQuehqXV3ucui8vm8YCOufYwj2Wjwx3CcE2DourDzyTtKv53LPK/Fz1M5PAGRNdsAIKj
 bO3vOu6X06VOTo0XH8SXdjrvrE9azf4qJEek9V7PjsFw50AHNk+SxUWS1jrukw+OJIJ/
 FaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1NWuugkWpQRRWA/1rSmW1lzMgKVNslNjLRYEkdR1Nr8=;
 b=ctiMu5EtXab1b9J5qXL82puaOYDo51GtoY6xIH+7wBm8s+n8VHLhmAxr3/hVyPXAtz
 3zXCm+w3s4RejRAwGOmD4/xOUSDvju7/foD359RMTrV37U2wU3eSsJbhrobsfUZ4xhTs
 2szpi1wls46fYxbr3kG9BvT+osst4jQLclh/4mpKeIBluVGKnyfFgt1XiEGr13vCXoOk
 LVzdo5+a1x/5tUGO3HdeG2rnAA1YTMBFW5wcKnHjIN/jWIqlZA6mnl0BxTEZZPi5ja65
 R3u0vi5ggJBpHG9Gkt0OFOXR5572RMj+hJNIqJdIfyLvcbmT3kkx3zt37fhPxovj+61d
 RqQw==
X-Gm-Message-State: APjAAAVRMM4ktL4YNPDZzJO8Xamm3pAOXT0ALIic/D73jgCyzS/9bYx2
 4J8pFWkiJzkkjRWWwDg8Ejtz+2f7H4KeoxmQouZTqGoS
X-Google-Smtp-Source: APXvYqx8zTScvrcOMIUQcp6YiIXAtTO5C4EC3YusWLTaHpQGKmpnKkByyxWWHYm2mGvPVmZ4pHgwJqvrnr9pIKweO4c=
X-Received: by 2002:a50:f48d:: with SMTP id s13mr59668225edm.151.1558113732961; 
 Fri, 17 May 2019 10:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <CA+CK2bBeOJPnnyWBgj0CJ7E1z9GVWVg_EJAmDs07BSJDp3PYfQ@mail.gmail.com>
 <20190517143816.GO6836@dhcp22.suse.cz>
In-Reply-To: <20190517143816.GO6836@dhcp22.suse.cz>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 17 May 2019 13:22:02 -0400
Message-ID: <CA+CK2bA+2+HaV4GWNUNP04fjjTPKbEGQHSPrSrmY7HLD57au1Q@mail.gmail.com>
Subject: Re: NULL pointer dereference during memory hotremove
To: Michal Hocko <mhocko@kernel.org>
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
Cc: "sashal@kernel.org" <sashal@kernel.org>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "Wu,
 Fengguang" <fengguang.wu@intel.com>, "david@redhat.com" <david@redhat.com>,
 "tiwai@suse.de" <tiwai@suse.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Huang,
 Ying" <ying.huang@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jmorris@namei.org" <jmorris@namei.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "jglisse@redhat.com" <jglisse@redhat.com>,
 "baiyaowei@cmss.chinamobile.com" <baiyaowei@cmss.chinamobile.com>,
 "zwisler@kernel.org" <zwisler@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "bp@suse.de" <bp@suse.de>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, May 17, 2019 at 10:38 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 17-05-19 10:20:38, Pavel Tatashin wrote:
> > This panic is unrelated to circular lock issue that I reported in a
> > separate thread, that also happens during memory hotremove.
> >
> > xakep ~/x/linux$ git describe
> > v5.1-12317-ga6a4b66bd8f4
>
> Does this happen on 5.0 as well?

Yes, just reproduced it on 5.0 as well. Unfortunately, I do not have a
script, and have to do it manually, also it does not happen every
time, it happened on 3rd time for me.

Pasha
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
