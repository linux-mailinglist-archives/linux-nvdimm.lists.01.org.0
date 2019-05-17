Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A0421C60
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 May 2019 19:25:06 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E770721274216;
	Fri, 17 May 2019 10:25:04 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com;
 envelope-from=pasha.tatashin@soleen.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id F3D3B212532E1
 for <linux-nvdimm@lists.01.org>; Fri, 17 May 2019 10:25:02 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id e24so11615325edq.6
 for <linux-nvdimm@lists.01.org>; Fri, 17 May 2019 10:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KwxwPmgRkigdfsb2Wkb3RXFjzIqZbXV/qcyPm1HcIzw=;
 b=h+8kfPwUUJsUPbqk+gDlpRaeblBYE2fVW4Jl93m9L3oQKmknNCCYpao0UAd7gBMUks
 hPvzLnV7CdDh1/rNOvJ7v46flOg1P7P7cz6XzbCBCYHErwbjvAFHO8kAhowextIXP4K4
 wzyiG8+QdxKuZNzJAzTPlvWNsDUXruxytbe9VLr0sdzVqplAx0E4U5nvXrgAe4wbMxl6
 QCdQFy8r/2NXOgZ7Bbo8ZNYPwRVsY0c/6q0Ka037S0t7VHH6Oc7AMl/o6AVCy4Fohq/H
 1yjg5kwJzWMAQJFZgNugwf1zgUhfH+A3fbYIKv1b5n1rqomPr0aaze9q+ODnrQSUr8zZ
 LBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KwxwPmgRkigdfsb2Wkb3RXFjzIqZbXV/qcyPm1HcIzw=;
 b=hK4V0VTyN+k74ISyvNu11UMTp/KKaNlu7VtRiuaj+UnEQ9YJ4es+rJkiedSr41HqZ9
 tRd9ZG1Top1wWsz4DqbfK0QVzsvSAQ66TRiQy7sI8H2W5LMly0pFpsmQm9VANlsdjUsA
 xw8CanGR3HvTMfoK1qU+DZ7aSdBvS92oagC8Xa39/itjKBRFT97ecSs4iZ8tSJRf+0M/
 t6UqSv1VR+zFVZTpz1etXoRIz34afiz1o/G4VDrX0vvVsHhjH1xuc1nbHiankGeNJVDF
 hSXT7roXLF5Z0Uxd+9iwLKkZdb+8BU5KuvKkGen4mPYHOrVgHj4jpxHBSV5UX5uUOt0j
 Fs6w==
X-Gm-Message-State: APjAAAWADGeiO1ZmL8lB1mhCVk0iAli8XI5EUG4pHiB4COlyhi5COKmT
 r4AHhANa+K5LN76VPA2A0NGJ/R6kd2hOgYB39k8A1/gQzlY=
X-Google-Smtp-Source: APXvYqwuyoSofrRAesux3TtniZbFtgeLGQpt/aaMsVyOQkqGRmuP2nmCLcnqBJYgiPbnM95G5HbA4GXqURtKw0f2SUc=
X-Received: by 2002:a50:ec87:: with SMTP id e7mr58594743edr.126.1558113901537; 
 Fri, 17 May 2019 10:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <CA+CK2bBeOJPnnyWBgj0CJ7E1z9GVWVg_EJAmDs07BSJDp3PYfQ@mail.gmail.com>
 <20190517143816.GO6836@dhcp22.suse.cz>
 <CA+CK2bA+2+HaV4GWNUNP04fjjTPKbEGQHSPrSrmY7HLD57au1Q@mail.gmail.com>
In-Reply-To: <CA+CK2bA+2+HaV4GWNUNP04fjjTPKbEGQHSPrSrmY7HLD57au1Q@mail.gmail.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 17 May 2019 13:24:50 -0400
Message-ID: <CA+CK2bDq+2qu28afO__4kzO4=cnLH1P4DcHjc62rt0UtYwLm0A@mail.gmail.com>
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

On Fri, May 17, 2019 at 1:22 PM Pavel Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Fri, May 17, 2019 at 10:38 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Fri 17-05-19 10:20:38, Pavel Tatashin wrote:
> > > This panic is unrelated to circular lock issue that I reported in a
> > > separate thread, that also happens during memory hotremove.
> > >
> > > xakep ~/x/linux$ git describe
> > > v5.1-12317-ga6a4b66bd8f4
> >
> > Does this happen on 5.0 as well?
>
> Yes, just reproduced it on 5.0 as well. Unfortunately, I do not have a
> script, and have to do it manually, also it does not happen every
> time, it happened on 3rd time for me.

Actually, sorry, I have not tested 5.0, I compiled 5.0, but my script
still tested v5.1-12317-ga6a4b66bd8f4 build. I will report later if I
am able to reproduce it on 5.0.

Pasha
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
