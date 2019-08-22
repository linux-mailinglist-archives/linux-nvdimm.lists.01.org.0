Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B5F996E0
	for <lists+linux-nvdimm@lfdr.de>; Thu, 22 Aug 2019 16:37:28 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ECE8320213F36;
	Thu, 22 Aug 2019 07:38:29 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b44; helo=mail-yb1-xb44.google.com;
 envelope-from=rosie.huynh@autovalidinfo.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com
 [IPv6:2607:f8b0:4864:20::b44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id BF66C20212CA0
 for <linux-nvdimm@lists.01.org>; Thu, 22 Aug 2019 07:38:28 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id u32so2587351ybi.12
 for <linux-nvdimm@lists.01.org>; Thu, 22 Aug 2019 07:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=autovalidinfo.com; s=google;
 h=mime-version:sender:from:date:message-id:subject:to;
 bh=GtXmYiy4j4N67aN8U2infiYLR3/BkbTRhzP2lAszJ/E=;
 b=pDppy81Gv/cvexFwRwwj0UvxyeLla52KWNbEjgD1LbhqhmXZrb65niF8OQZK2zrmfI
 HGmz1HE8kh2MJtj1EAt0CwlJEZPGmtnStGUK/PiegXI0dq9BVTUetHhxNY60XVrVpxlh
 mXZKwmRsugfnzpmUs8rO0Ssa1UTkIno86oIYJ//HI09HEJr24MYgC2uteXGQ97Sfns3J
 +lijBdVVycGNmHMt7qP+JHnlWlqhgN7Al2IkuowK576hPmrznIB+3YY+RxxqhCx78ObG
 818+adJNUfRQgadPbm3wwPJminFVyt0oR0mpv2Sgl+kHtbrqN8twzTxf7hUlw9jkVCrK
 nlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
 :to; bh=GtXmYiy4j4N67aN8U2infiYLR3/BkbTRhzP2lAszJ/E=;
 b=LEQl6vdvYZv8O3LnrzGaihkjiL3CWo2o/czNnTzsLXNwzOAE0UpD1VNesKa26h3+Q4
 PccIsNUrnCOBPSTwHKpPyVN8Z7wr+++Lq8N+qWJxJkW8yKk73KRStWP7GRlwQWM3AZHc
 iPfGa2MSa38cCfwHNbN/jvYcWQQ1EJ5MCXdN7L4KrfFYkDojTlHs8szIRHUV41hx8mzB
 vxQKPF7PPU0AbwfzU9OU82PP9KmiPGMxiMMacyUSen/NPndwogA8cMZHhhpZOIpdZfJO
 TA/cJhyhyU7GVUSZznBvhu8YTrhzYS9Gu0CAqoRrRzBv+Vl5brtNtYt4yiKH2jKNNZkk
 t8Ow==
X-Gm-Message-State: APjAAAW0VSm5To5KDO94fDNiK6WvqU4ZHXopZkv+hWOD6j8lh1Kzhftf
 Ziv0edyqbsnopwyQGHEkTpsLd2cB6zdAxRoP065Yxvsm6NQ=
X-Google-Smtp-Source: APXvYqyrl5+tU6oUAs1LYrq0BepZCNv+zWDuBRV87NAS4dIZVwtsmvyCOm5OZAzefLt5CbjlOdgcFn2jmbGe2u2YyCE=
X-Received: by 2002:a25:a545:: with SMTP id h63mr18086753ybi.257.1566484644073; 
 Thu, 22 Aug 2019 07:37:24 -0700 (PDT)
Received: from 158059779194 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Aug 2019 07:37:23 -0700
MIME-Version: 1.0
From: rosie.huynh@autovalidinfo.com
Date: Thu, 22 Aug 2019 07:37:23 -0700
X-Google-Sender-Auth: JnqrjKsJO8KhO3ZGEqf3vp2_tUU
Message-ID: <CAAJs2D63ULhdmwH1-XWQ=vEjQsrQSU8PQKQzrKGWVRJiafKm_A@mail.gmail.com>
Subject: Managed Security Service Providers (MSPs & MSSPs)
To: linux-nvdimm@lists.01.org
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Hello,



Would you be interested in acquiring the updated and verified mailing
address of* Managed Security Service Providers* (*MSP & MSSPs*)?



We also have data intelligence of:



Managed Security Service Providers (MSSPs)

Value Added Resellers (VARs)

Independent Software Vendors (ISVs)

System Integrators (Sis)

VoIP Service Providers.

Telecommunications Service Providers (TSPs)

Application Service Providers (ASPs)

Internet Service Providers (ISPs)

IT Managed Services Providers (ITMSP)

Storage Service Providers (SSPs)



Please let me know if this is something of interest to you so that I can
provide you with further information.



Thanks

Rosie Huyun.

If see no interest please reply *No Need.*
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
