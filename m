Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D9612CBF3
	for <lists+linux-nvdimm@lfdr.de>; Mon, 30 Dec 2019 03:33:05 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7048310097F34;
	Sun, 29 Dec 2019 18:36:23 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::d41; helo=mail-io1-xd41.google.com; envelope-from=pjius001@gmail.com; receiver=<UNKNOWN> 
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4215C10113672
	for <linux-nvdimm@lists.01.org>; Sun, 29 Dec 2019 18:36:21 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id r13so20271856ioa.3
        for <linux-nvdimm@lists.01.org>; Sun, 29 Dec 2019 18:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=cCgjmSxLWlMql57U+O40bnMOsF2pBGMu0xtRuJWN4EM=;
        b=rTjGD8zCXNl+slLBt4FM7My74WqMEr0Jw5goLp9m6Q1v2x59gQl/mDSX/NZGJhHZcM
         pa2xy4y7bF4prnH/ChbD7xKp7xFADGIdf05T2eiAtGpYCAka/i50tD+Pl5Jh77it3z0q
         A3mHnOzdxds50kxmlSvlaRiewghIGlLmMmstFH77406tLci1ZPDMqmSBVf79/w/r9USF
         bR++6aqX89S2KVvHDtrWQQhOwMkVB2Qwl5vy1iJKxkPZ5L9iM+tDszRqA5aWxcfrlJZI
         CsLNumDQK6lJ9X9dn2lWX4wm+vnJtJtDl0SD1vIcdKiHAboDud0qKd8WP6uBuW/jJGUS
         JHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=cCgjmSxLWlMql57U+O40bnMOsF2pBGMu0xtRuJWN4EM=;
        b=C/USUMDJ4AauCHqwQ5NdGD/n35WrfJsvgC/ennHNDCWznHIhCfhTdcUC7qAEIBW7bc
         PqiHruyUFmxMLSxc02+2j9OWuMJyDFv27Ivth7UEQcE1SLDwmG6LKhMOOEL+TBQ1rc7v
         OBYB/oGR2TyJ9UPEK99fLvcA4nhU6wIt36ptR64MEAj4+ktzUtBPb4TEzczhWRDZcg72
         fEiynLhPIU1NkqFneCPbbiIKYPy3KDGs4jXGjR040rcMhi2od3ARWHA+wDeKpja8vMlV
         NbTR9oybD5Mv1aLjxgtBrAt4objjP+8zQ7toLaIq+75Azqq9REe3xhXKN967G4JHtLm5
         P1qg==
X-Gm-Message-State: APjAAAU+kmyJw8A4Hp11x7WL1g+IrU+EipvJBt/1yGjHfC9I3nJPyYlY
	6A6IMK48HLGKzbpc3L/TUx+9WA0okcJ1Saak7wg=
X-Google-Smtp-Source: APXvYqx+T4jxIR4TPQyusPMf5p0Bx8Oc1vlHyHGyMTWE9l6KSrhWtXykCiV+tvAikXX13GmWiINA7BgvpFWrIK5IwDk=
X-Received: by 2002:a5d:97c3:: with SMTP id k3mr26352849ios.38.1577673180060;
 Sun, 29 Dec 2019 18:33:00 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac0:da0d:0:0:0:0:0 with HTTP; Sun, 29 Dec 2019 18:32:59
 -0800 (PST)
From: "Mr. Moon David" <pjius001@gmail.com>
Date: Mon, 30 Dec 2019 02:32:59 +0000
Message-ID: <CAA0xNFD=Hmn_LL=-a0wujEvpX0ptmP84i4k1tsNgUh4_nB7CoA@mail.gmail.com>
Subject: Greetings
To: undisclosed-recipients:;
Message-ID-Hash: 7T4QYHIM7AGMO4XYQAJCXV45TRRFYKFU
X-Message-ID-Hash: 7T4QYHIM7AGMO4XYQAJCXV45TRRFYKFU
X-MailFrom: pjius001@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: moon.david001@yahoo.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7T4QYHIM7AGMO4XYQAJCXV45TRRFYKFU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Sir/Madam,

I have investor that want to invest $6.8 Billion into a  company that
needs fund  for expansion only.He can not invest the money to new
Companies that want to start up but into Companies that has been
making good profits but needs funds for EXPANSION. He can only invest
in start up if the investment proposal is realistic. The investor is a
former Petroleum Minister.

His Area of concentrations are Real Estate, Biotech,Textiles ,
Information technology, Pharmaceuticals , Oil & Energy Industries,
Mining &Metals Industry, Management Consulting Industry ,Maritime
industry, Hospital & Health Care Industry, Consumer Services Industry,
International Trade and Development Industry ,Gambling & Casinos
Industry, Electrical/Electronic Manufacturing Industry, Insurance
Industry, Chemical industries, Marketing and Advertising Industry,
Leisure, Travel & Tourism Industry, Agriculture, Aviation, Retail,
Import and Export, Trade and development industry, Real Estate &
Construction Industry and any other viable investment opportunities.

If you recommend a Company to take loan or investment funds from from
my client the investor, me and you will be entitled to 5% of any
amount received by the Company from the investor but if you are taking
the fund directly as a company i will be entitled to 2.5% and you will
retain 2.5% as Global Finder's fee commission. There will be a face to
face meeting between the investor and the investee after signing (MOU)
the (AORI) should not be less than 3% per annul if it's loan or direct
project financing.

Look for a reliable Company that need funding and we can easily make
5% of the amount received from the investor but we need to maintain
absolute confidentiality in the transaction as the fund provider want
to remain silent, so you have to keep it highly confidential between
us.

I will need the company profile and the project summary of the company
that will need funding to present to my investor.

I look forward to hearing from you.
Mr. Moon David.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
