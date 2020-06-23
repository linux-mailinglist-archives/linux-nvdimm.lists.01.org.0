Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7479620502E
	for <lists+linux-nvdimm@lfdr.de>; Tue, 23 Jun 2020 13:13:35 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CC0A210FC3C35;
	Tue, 23 Jun 2020 04:13:33 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::142; helo=mail-il1-x142.google.com; envelope-from=elnana194@gmail.com; receiver=<UNKNOWN> 
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DBE5110FC3777
	for <linux-nvdimm@lists.01.org>; Tue, 23 Jun 2020 04:13:31 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id w9so4958904ilk.13
        for <linux-nvdimm@lists.01.org>; Tue, 23 Jun 2020 04:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=D7l/Y2nU4ivOXB3kYNarWKNDy1SUWuawPt7q4q/Bhv4=;
        b=JmFWxL8jcgFtJ4lXeAh1tsN1JKedqnhe1aARR5DLLNfnmxbRVdigZWObFQCKHma7V/
         nXcD5YIWEVXNXCqrytPGgDqMF7LG3AjbXiqLTgzqk1NJVD0/SRZf4OoSI6wnKQxYV3Ks
         amS6a4QzU5emTI071jmI7+yuVO8cf4VT9H8sEhnpri7+7G+PTXCBUyZqsrxfqxuiwOG4
         xEIjMamwRMoIta8KsYy3dHkpvW0oyFzbTuaV2CPgDnFo04GeMPe10QjUEXx8wj4RHH8B
         DHZEqlRnedz4pCoeB0pVzmh4bko7PaIqIxbPCx2izv0Xwb2Gc8VLztOXP6mjnrkcvxdC
         tn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=D7l/Y2nU4ivOXB3kYNarWKNDy1SUWuawPt7q4q/Bhv4=;
        b=PqIVertyCD/YvzIHOdMCG7e5MontoEzlAnzENbFciJnLSNCjdbOUWyGbaHRzcnn8HL
         cX9X/9bY23vItpJGzIhL/uHIeGg4OzstfUEEi8J2Kc1b49SBm2N4T2zWrIxv68Zb1Fj0
         517gwp/RLiQBVAQ7qVmYMUd2mmX8H8aXXjhXBcqEKIIquLS2vhr+eA+YieSj7QCZbxSv
         ctPfQ7CpQ19SRN4tvnaUK7izLGjVVjTPIjuKKmsGLTO4dKcshPye8rFvZLbLncGp3Ex8
         6SqL9OAha1Szn19j0HibJg2CkqilgliTES3ti4m/yWeQMgyFccQYXR/iiONB6nS69vbh
         q/yg==
X-Gm-Message-State: AOAM5335AMnsF1sZ/jet6hCoLdQt2zj0lH1hchdqrBKS4toClwVdI7Eb
	NrAIYNm+C47ypbB18bWOzNdO683/tCCadM+KOBY=
X-Google-Smtp-Source: ABdhPJwK923lg5M3WnkXSapWWzottNhCJnxFSYd3ngrqt2SS9qPX4AJ/vikM4fv3WoLbmggVNNCfvDQtP1sd5XzwhK0=
X-Received: by 2002:a92:c643:: with SMTP id 3mr23427492ill.229.1592910811076;
 Tue, 23 Jun 2020 04:13:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:14d3:0:0:0:0 with HTTP; Tue, 23 Jun 2020 04:13:30
 -0700 (PDT)
From: Sarah Koffi <elnana194@gmail.com>
Date: Tue, 23 Jun 2020 12:13:30 +0100
Message-ID: <CA+NUCuTpRBCNhzPsUx6VPrOLF5ST46h_JaJQFi9zwqK2yEciSw@mail.gmail.com>
Subject: Greetings From Mrs. Sarah Koffi
To: sarahkoffi389@yahoo.co.jp
Message-ID-Hash: GSF4EI53CUHBQMRM35EUG4DVSI6J2YHL
X-Message-ID-Hash: GSF4EI53CUHBQMRM35EUG4DVSI6J2YHL
X-MailFrom: elnana194@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: sarahkoffi389@yahoo.co.jp
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GSF4EI53CUHBQMRM35EUG4DVSI6J2YHL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Greetings From Mrs. Sarah Koffi

I'm contacting you based on your good profiles I read and for a good
reasons, I am in search of a property to buy in your country as I
intended to come over to your
country for investment, Though I have not meet with you before but I
believe that one has to risk confiding in someone to succeed sometimes
in life.

My name is Mrs. Sarah Koffi. My late husband deals on Crude Oil with
Federal Government of Sudan and he has a personal Oil firm in Bentiu
Oil zone town and Upper
Nile city. What I have experience physically, I don't wish to
experience it again in my life due to the recent civil Ethnic war
cause by our President Mr. Salva Kiir
and the rebel leader Mr Riek Machar, I have been Under United Nation
refuge camp in chad to save my life and that of my little daughter.

Though, I do not know how you will feel to my proposal, but the truth
is that I sneaked into Chad our neighboring country where I am living
now as a refugee.
I escaped with my little daughter when the rebels bust into our house
and killed my husband as one of the big oil dealers in the country,
ever since then, I have being on the run.

I left my country and move to Chad our neighboring country with the
little ceasefire we had, due to the face to face peace meeting accord
coordinated by the US Secretary of State, Mr John Kerry and United
Nations in Ethiopia (Addis Ababa) between our President Mr Salva Kiir
and the rebel leader Mr Riek Machar to stop this war.

I want to solicit for your partnership with trust to invest the $8
million dollars deposited by my late husband in Bank because my life
is no longer safe in our country, since the rebels are looking for the
families of all the oil business men in the country to kill, saying
that they are they one that is milking the country dry.

I will offer you 20% of the total fund for your help while I will
partner with you for the investment in your country.
If I get your reply.

I will wait to hear from you so as to give you details.With love from

 i need you to contact me here sarahkoffi389@yahoo.co.jp

Mrs. Sarah Koffi
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
