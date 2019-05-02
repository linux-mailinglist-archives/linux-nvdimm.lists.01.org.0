Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD46F11B26
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 May 2019 16:17:10 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 72B2A21243BA6;
	Thu,  2 May 2019 07:17:09 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=pasha.tatashin@soleen.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 8597821237AD3
 for <linux-nvdimm@lists.01.org>; Thu,  2 May 2019 07:17:08 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id f37so2231241edb.13
 for <linux-nvdimm@lists.01.org>; Thu, 02 May 2019 07:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3UwUTSGK3kFDqh59G348P1VSE287YQFCPyBJWkFGT2g=;
 b=jeL1TmN+9S7rxFSCfW9V3bYCQ9XkkRpCSHGcvfnrOsvTSAjY73LFSt1bUiVgtgHJNq
 Tv0DbnVWNwa8ZjVzru05IQyRWy3S/5OEqtHtNfr/GR2TVOwOJqI+yAZuJXWBMCL2pG4f
 re8W5PiiN/831GI+qo4H8mGQodK+253IOfYP2SJv+auBn37OqlvdOokiv0/y9Xk/xMCg
 T+14TN7gujRPTIqhsFgKKnmV+jKUYGVd5KWX38nwgSzlaAx0CpwFF17YHopwjY1k7gtD
 MLtUmtFpfiEFPRQtO43++BKD+FVRV2u7zlgVjWl+zwgCdyeyyFCx6zLeHvXkzQcj824S
 TQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3UwUTSGK3kFDqh59G348P1VSE287YQFCPyBJWkFGT2g=;
 b=O1ISEPPJB48Luq4y5M8jA86dNOcOX0lYZR6LIoG0tSs20uP4IqIiNWYSMg3Y7tBgFK
 lPRJWXXcX700bdMinE8Pwrxo7IYUe9IZQyvJ58PhyyjhLWrSjHytEKbLwU/JmFwJrbx3
 h4yMcOGRA2+hOHNBS38tEAbnlcX3IlgA8vZaK1aNN12h3mN9qyMTCcURfea2jAeNonqI
 s2CAUR4nwLIGivbYzihMrUvhF9b+gKj0DZOAVIhTGvHXu+NKSvz4nRXI9D97TJgISZIo
 8sF0hrINWhcORkAkEccTBAQtVjILeC03xpob9XoGUK6bf0630CLDRrrh+CGUZnbimPTk
 H3dg==
X-Gm-Message-State: APjAAAUZ+8MUZY0W14cnKjQs0OgOQhGyoGWmtLdY5ijYj8fmP7+maaDA
 XyZWXHwxYtCDfroqCan4ArN1KNkhPeJxEnh7wFcL1g==
X-Google-Smtp-Source: APXvYqxfxStCJ1a5V9dI9KazHvlQKGkMxuucoOz7ty4S41uLly2rKv78x1mRLAhuezLjjjPUXOHuGcrzAp0ZhX1u2YU=
X-Received: by 2002:a05:6402:13cf:: with SMTP id
 a15mr2763367edx.70.1556806626879; 
 Thu, 02 May 2019 07:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190501191846.12634-1-pasha.tatashin@soleen.com>
 <20190501191846.12634-3-pasha.tatashin@soleen.com>
 <9e15bf41-8e74-3a76-c7b9-9712b2d5290b@redhat.com>
In-Reply-To: <9e15bf41-8e74-3a76-c7b9-9712b2d5290b@redhat.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 2 May 2019 10:16:56 -0400
Message-ID: <CA+CK2bCfCoU3JHz=81+=RNwo9M6n_zRbmPgx+DNmAnPYQRcjOA@mail.gmail.com>
Subject: Re: [v4 2/2] device-dax: "Hotremove" persistent memory that is used
 like normal RAM
To: David Hildenbrand <david@redhat.com>
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
 LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Borislav Petkov <bp@suse.de>, Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
 Ross Zwisler <zwisler@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Fengguang Wu <fengguang.wu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

>
> Memory unplug bits
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
>

Thank you David.

Pasha
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
