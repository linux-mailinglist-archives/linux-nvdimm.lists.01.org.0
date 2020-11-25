Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE792C4495
	for <lists+linux-nvdimm@lfdr.de>; Wed, 25 Nov 2020 17:00:25 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 04B60100ED4AB;
	Wed, 25 Nov 2020 08:00:24 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::12a; helo=mail-lf1-x12a.google.com; envelope-from=kumsonkington@gmail.com; receiver=<UNKNOWN> 
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1E8B4100ED4AB
	for <linux-nvdimm@lists.01.org>; Wed, 25 Nov 2020 08:00:20 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id j205so3828234lfj.6
        for <linux-nvdimm@lists.01.org>; Wed, 25 Nov 2020 08:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=LTjiRN6GWpIjZZcdnIBBIo00u6kMbYPc0UAhfj0YtNY=;
        b=MTn7Pxs3o4AtmoNxEpglYN17C+X4YEa0jpMzAieDENaAhBfVn8+Dmg+DmHSc6AHRnC
         t/66Y/45GP8KyYrYLXNjK1uIya9eq+8TXgsV9yyxkqlJ46jD6rh1IopZhUh+RQZJo4cf
         VmA/4+5gW6kOUqM68fOvGKIp7z0/lMiQOXlWCDJYNvI/r2qIucrlfNB9ktpTWTkFkKmM
         u5ZW9/F11bNrQLQasmmP726ta+Ea9JhlI/k4EUhRt4yUyvMDCnTGstgdmFs4HsspLIX+
         pII4GFtHqGtz/TbBtas4skgiros90GYEytx+BBiPR28g5Hv/JezXYnrcMM/JdsQWCFVL
         35fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=LTjiRN6GWpIjZZcdnIBBIo00u6kMbYPc0UAhfj0YtNY=;
        b=gSd7YZk2XQ7WH2r12f2LOkQO4qqLOJkvneyzWpBLFmb9lojNuYqVqGRKbe6aT1BgMg
         pg8AA6c5Ppe8a8gHsTFEbigpq0iCNZsFmocLERMBa+hTlMZYoJe+OW+QM5cqOULZwg6J
         0sD4bTqbL60Z/jtcf0+lSPJ9iZJpvOtha8H1LdZvduYPtdr2j6fm30+pJQ/byrjSJMmg
         uPlT3LLvGnX8rHuSPvBnPqazv3rGa7f6SAnmaZcIf7iAHklH+c3nvVqttdiAP47PR+wI
         j//fdCft7LLkFDW+zN4DwQWDMsa3HvPKYYmssTQtXEmYw1GUwoKmI5fiDte8d3OCj0mU
         XQPg==
X-Gm-Message-State: AOAM531RBSdh9hPZ0MJF4IBC1NCfPJ6EhP/5/C9RRH12Fjj5ieois0IU
	cZrOSWGAndMAktioXdd2cQkKkyghjopsHRo/6D4=
X-Google-Smtp-Source: ABdhPJwljXGPzviEDrSSaO1/WuHiVvxSt62ou/27tpQCBDLKgChWk3p4DeRsci5AnJ0EbqZUNDpWbfC5cjs1c9innm0=
X-Received: by 2002:ac2:5e23:: with SMTP id o3mr1768821lfg.159.1606320016109;
 Wed, 25 Nov 2020 08:00:16 -0800 (PST)
MIME-Version: 1.0
From: kumson kingston <kumsonkington@gmail.com>
Date: Wed, 25 Nov 2020 08:00:16 -0800
Message-ID: <CAKGseovuR4XHacR1Kh6TsCTO4J5phUamNE5kqe8XVhFXUrNmOw@mail.gmail.com>
Subject: Request For Partnership.
To: undisclosed-recipients:;
Message-ID-Hash: WZ5ZJX3TV53AW474M5PJMAUBY6PXLQ6R
X-Message-ID-Hash: WZ5ZJX3TV53AW474M5PJMAUBY6PXLQ6R
X-MailFrom: kumsonkington@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: kumsonkingston@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WZ5ZJX3TV53AW474M5PJMAUBY6PXLQ6R/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

  Hello A Request For Partnership.
I am particularly happy dealing with a person of your caliber who knows
what international business is all about. This business is purely based on
trust and it's 100% risk free business and I understand your willingness to
assist me in actualizing this deal. As I told you in my first email, all I
need from you is a confirmation that you can handle this deal in question,
and then all the details will be given to you as we progress. My name is
Mr. Kumson Kingston., the Vault Manager with a Private Storage Firm. Having
worked with this storage company for the past 18 Years with dedication and
having nothing to write home about. Hence I have to package this deal for
our betterment.
 There is this UNCLAIMED Trunk Boxes Deposited in our Company's Vault for
the past 15 years ago, and nobody has ever shown up for the claims and
collection till date. Having made inquiry and investigation why these Trunk
Boxes has not been claimed by their depositors/Owners I discovered they are
late/dead for the past 10 year ago, no forwarding contact addresses of this
depositors/Owners, as every effort to locate any  surviving relatives or
close family members of his proof abortive.
 Just few Months ago, the Management and board of directors resolved to
dispose All Unclaimed Trunk Boxes that has exceeded the period of 6year
without it depositor coming for claims and collection be dislodged from the
Vault and disposed, So as to create space to accommodate incoming Boxes.
Actually, Many Boxes were dislodged from our Vault for disposal but being
the Vault Manager, I decided to checkmate the contents of these boxes.
After scanning these few Boxes electronically, I discovered wonders, their
contents to be fiscal cash running into Millions of United States of
American Dollars in $100 bills.
May it interest you, to note that none of the staff or management of our
company know anything relating to this development till date, I'm
contacting you believing that you could afford me the assistance and help I
need to legally secure and claim these Trunk Boxes from our company Vault
for further delivery to your doorstep or any country of your designation.
While upon completion of the clams and delivery to your doorstep I'll later
join you in your country to Disburse/Share the proceeds of the Trunk Boxes
50% / 50% with you.
Should you need to peruse copies of the deposit Documents covering these
Boxes issued to the late depositor by the management of our Firm, I will
gladly and not hesitate to present them to your perusal and study. Should
this interest you to partner with me, then Kindly forward your full contact
Address, direct Telephone, Cell Phone numbers known to me. I guarantee you
that, if only you give me a chance and cooperate with me within the next
ten (10) working days from today the Trunk Boxes will be released and we
process it onward delivery to your doorstep in your country. I know how to
handle this and immediately after the completion of this transaction I will
personally destroy and delete every information leading to the completion
of this transaction. This is to assure you that I will not leave any traces.
Best Regards.
Kumson Kingston
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
